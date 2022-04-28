defmodule Midterm.PriceServer do
  defmodule State do
    defstruct [:id, :token_name, :fetch_interval, :price, :time_last_fetched]
  end

  use GenServer
  require Logger

  alias Midterm.PriceServer.State
  alias Midterm.PriceServer.Supervisor

  @tokens ["ADA"]
  @fetch_price_impl Application.compile_env!(:midterm, :fetch_price_impl)

  def start_token_price_servers(@tokens) do
    for token <- @tokens do
      start_server(token_name: token)
    end
    |> ensure_all_token_servers_started()
  end

  def start_link(opts) when is_list(opts) do
    token_name = Keyword.fetch!(opts, :token_name)
    fetch_interval = Keyword.get(opts, :fetch_interval, 10_000)

    state = %State{token_name: token_name, fetch_interval: fetch_interval}

    GenServer.start_link(__MODULE__, state, name: via_tuple(token_name))
  end

  def get_price(id) when is_binary(id) do
    GenServer.call(via_tuple(id), :get_price)
  end

  defp via_tuple(id) do
    {:via, Registry, {Registry.PriceServer, id}}
  end

  def init(state) do
    Logger.info("server started for #{state.token_name}")
    {:ok, state, {:continue, :start_up}}
  end

  def handle_continue(:start_up, state) do
    price = fetch_price(state.token_name)
    time_last_fetched = Time.utc_now()

    {:noreply, %{state | price: price, time_last_fetched: time_last_fetched}}
  end

  def handle_call(:get_price, _, state) do
    if fetch_new_price?(state) do
      price = fetch_price(state.token_name)
      time_last_fetched = Time.utc_now()

      {:reply, price, %{state | price: price, time_last_fetched: time_last_fetched}}
    else
      {:reply, state.price, state}
    end
  end

  defp fetch_price(token_name) do
    @fetch_price_impl.fetch_price(token_name)
  end

  defp fetch_new_price?(state) do
    Time.diff(Time.utc_now(), state.time_last_fetched, :millisecond) > state.fetch_interval
  end

  def start_server(opts \\ []) do
    Supervisor.start_child(opts)
  end

  defp ensure_all_token_servers_started(responses) do
    Enum.reduce_while(responses, :ok, fn
      {:ok, _pid}, :ok ->
        {:cont, :ok}

      {:error, {:already_started, _pid}}, _ ->
        {:cont, :ok}

      error, _ ->
        Logger.warn("error starting token price servers")
        {:halt, {:error, error}}
    end)
  end
end

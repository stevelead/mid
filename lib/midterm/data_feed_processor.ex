defmodule Midterm.DataFeedProcessor do
  @moduledoc """
  A socket client for connecting to that other Phoenix server

  Periodically sends pings and asks the other server for its metrics.
  """

  use Slipstream,
    restart: :temporary

  require Logger

  alias Midterm.Accounts
  alias Midterm.DataFeed.BlockProcessor

  @topic "wmt:blocks"

  def start_link(args) do
    Slipstream.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl Slipstream
  def init(_args) do
    with {:ok, config} <- Application.fetch_env(:slipstream, __MODULE__),
         {:ok, socket} <- connect(config) do
      {:ok, socket}
    else
      :error ->
        Logger.warn("""
        Could not start #{inspect(__MODULE__)} because it is not configured
        """)

        :ignore

      {:error, reason} ->
        Logger.error("""
        Could not start #{inspect(__MODULE__)} because the configuration is invalid:
        #{inspect(reason)}
        """)

        :ignore
    end
  end

  @impl Slipstream
  def handle_connect(socket) do
    {:ok, join(socket, @topic)}
  end

  @impl Slipstream
  def handle_join(@topic, _join_response, socket) do
    watched_addresses = Accounts.list_watched_addresses() |> Enum.map(& &1.address_hash)
    push(socket, @topic, "all_addresses", %{addresses: watched_addresses})

    {:ok, socket}
  end

  @impl Slipstream
  def handle_message(@topic, "new_block", %{"block" => block}, socket) do
    Logger.info("received block #{block["id"]}...")
    BlockProcessor.process_block(block)
    Logger.info("completed handling of block #{block["id"]}...")

    {:ok, socket}
  end

  @impl Slipstream
  def handle_message(@topic, event, message, socket) do
    Logger.error(
      "Was not expecting a push from the server. Heard: " <>
        inspect({@topic, event, message})
    )

    {:ok, socket}
  end

  @impl Slipstream
  def handle_disconnect(_reason, socket) do
    # clean up any previously set :timers here
    {:stop, :normal, socket}
  end
end

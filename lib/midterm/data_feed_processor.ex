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
    Logger.info("received block with id #{block["id"]}...")

    block
    |> transform_string_keys()
    |> BlockProcessor.process_block()

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

  def transform_string_keys(item) when is_map(item) do
    for {key, value} <- item do
      transform({key, value})
    end
    |> Enum.into(%{})
  end

  def transform_string_keys(item) when is_list(item) do
    Enum.map(item, &transform_string_keys/1)
  end

  defp transform({"id", value}), do: {:id, value}
  defp transform({"header_hash", value}), do: {:header_hash, value}
  defp transform({"slot", value}), do: {:slot, value}

  defp transform({"transaction_address_details", value}),
    do: {:transaction_address_details, transform_string_keys(value)}

  defp transform({"inputs_agg_assets", value}), do: {:inputs_agg_assets, value}
  defp transform({"inputs_agg_value", value}), do: {:inputs_agg_value, value}
  defp transform({"outputs_agg_assets", value}), do: {:outputs_agg_assets, value}
  defp transform({"outputs_agg_value", value}), do: {:outputs_agg_value, value}
  defp transform({"tx_utxo_balance", value}), do: {:tx_utxo_balance, value}

  defp transform({"transaction_id", value}), do: {:transaction_id, value}
  defp transform({"transaction", value}), do: {:transaction, transform_string_keys(value)}
  defp transform({"tx_id", value}), do: {:tx_id, value}

  defp transform({"address_id", value}), do: {:address_id, value}
  defp transform({"address", value}), do: {:address, transform_string_keys(value)}
  defp transform({"address_hash", value}), do: {:address_hash, value}

  defp transform({key, value}),
    do:
      Logger.warn(
        "#{__MODULE__} transform/1 received unexpected key value pair {#{key}, #{value}}"
      )
end

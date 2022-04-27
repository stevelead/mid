defmodule Midterm.DataFeedProcessor do
  @moduledoc """
  A socket client for connecting to that other Phoenix server

  Periodically sends pings and asks the other server for its metrics.
  """

  use Slipstream,
    restart: :temporary

  require Logger

  @topic "wmt:blocks"

  def start_link(args) do
    Slipstream.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl Slipstream
  def init(config) do
    {:ok, connect!(config)}
  end

  @impl Slipstream
  def handle_connect(socket) do
    {:ok, join(socket, @topic)}
  end

  @impl Slipstream
  def handle_join(@topic, _join_response, socket) do
    addresses = Midterm.Accounts.list_watched_addresses()
    push(socket, @topic, "all_addresses", %{addresses: addresses})

    {:ok, socket}
  end

  @impl Slipstream
  def handle_message(@topic, "new_block", %{"block" => block}, socket) do
    IO.inspect(block, label: "initiate block processing from here")

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

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
    {:ok, connect!(config), {:continue, :start_ping}}
  end

  @impl Slipstream
  def handle_continue(:start_ping, socket) do
    timer = :timer.send_interval(1000, self(), :request_metrics)

    {:noreply, assign(socket, :ping_timer, timer)}
  end

  @impl Slipstream
  def handle_connect(socket) do
    {:ok, join(socket, @topic)}
  end

  @impl Slipstream
  def handle_join(@topic, _join_response, socket) do
    # an asynchronous push with no reply:
    push(socket, @topic, "hello", %{})

    {:ok, socket}
  end

  @impl Slipstream
  def handle_info(:request_metrics, socket) do
    # we will asynchronously receive a reply and handle it in the
    # handle_reply/3 implementation below
    {:ok, ref} = push(socket, @topic, "get_metrics", %{format: "json"})

    {:noreply, assign(socket, :metrics_request, ref)}
  end

  @impl Slipstream
  def handle_reply(ref, metrics, socket) do
    if ref == socket.assigns.metrics_request do
      :ok = MyApp.MetricsPublisher.publish(metrics)
    end

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
    :timer.cancel(socket.assigns.ping_timer)

    {:stop, :normal, socket}
  end
end

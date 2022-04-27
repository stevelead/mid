defmodule Midterm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Midterm.Repo,
      # Start the Telemetry supervisor
      MidtermWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Midterm.PubSub},
      # Start the Endpoint (http/https)
      MidtermWeb.Endpoint,
      # Start a worker by calling: Midterm.Worker.start_link(arg)
      # {Midterm.Worker, arg}
      {Absinthe.Subscription, MidtermWeb.Endpoint},
      {Finch, name: MidtermFinch},
      {Midterm.DataFeedProcessor, uri: "wss://one-fly-app.fly.dev/socket/websocket"}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Midterm.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MidtermWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

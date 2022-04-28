defmodule Midterm.PriceServer.Supervisor do
  use DynamicSupervisor

  alias Midterm.PriceServer

  def start_link(_init_arg) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_child(params) do
    spec = {PriceServer, params}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  def init(init_arg) do
    DynamicSupervisor.init(
      strategy: :one_for_one,
      extra_arguments: init_arg
    )
  end
end

defmodule Midterm.DataFeed.HttpRequest.Mock do
  @behaviour Midterm.DataFeed.HttpRequest.Behaviour

  @impl true
  def add_address(address) when is_binary(address) do
    {:ok, address}
  end

  @impl true
  def add_address(_address) do
    {:error, "address must be a binary type"}
  end

  @impl true
  def remove_address(address) when is_binary(address) do
    {:ok, address}
  end

  @impl true
  def remove_address(_address) do
    {:error, "address must be a binary type"}
  end
end

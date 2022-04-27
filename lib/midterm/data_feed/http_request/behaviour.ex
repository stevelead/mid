defmodule Midterm.DataFeed.HttpRequest.Behaviour do
  @type address :: String.t()
  @callback add_address(address()) :: {:ok, address()} | {:error, String.t()}
  @callback remove_address(address()) :: {:ok, address()} | {:error, String.t()}
end

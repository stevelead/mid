defmodule Midterm.DataFeed.HttpRequest do
  def add_address(address), do: http_request_client().add_address(address)

  def remove_address(address), do: http_request_client().remove_address(address)

  defp http_request_client() do
    Application.get_env(:midterm, :http_request_client)
  end
end

defmodule Midterm.PriceServer.FetchPricesImpl do
  @behaviour Midterm.PriceServer.FetchPrices

  require Logger
  import Finch

  @binance_api_key Application.compile_env!(:midterm, :binance_api_key)

  @impl true
  def fetch_price("ADA") do
    with %{body: body, status_code: 200} <- binance_request(),
         {:ok, body} <- Jason.decode(body) do
      Map.get(body, "price")
    else
      {:error, error} ->
        Logger.warn("could not fetch price for ADA")
        {:error, error}
    end
  end

  def fetch_price(token), do: IO.puts("price fetching is not set up for token #{token}")

  defp binance_request() do
    url = "https://api.binance.com/api/v3/avgPrice?symbol=ADAUSDT"

    build(:get, url, "X-MBX-APIKEY": @binance_api_key, "Content-Type": "application/json")
    |> request(MidtermFinch)
  end
end

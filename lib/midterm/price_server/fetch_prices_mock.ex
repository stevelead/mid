defmodule Midterm.PriceServer.FetchPricesMock do
  @behaviour Midterm.PriceServer.FetchPrices

  @impl true
  def fetch_price("ADA") do
    decimal = Enum.random(1..999) / 1000
    "1.#{decimal}"
  end
end

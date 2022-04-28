defmodule Midterm.PriceServer.FetchPrices do
  @type price :: String.t()

  @callback fetch_price(token_name :: String.t()) :: price | :unknown
end

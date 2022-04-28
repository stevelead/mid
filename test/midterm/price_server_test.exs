defmodule Midterm.PriceServerTest do
  use Midterm.DataCase, async: true

  alias Midterm.PriceServer

  describe "start_link/1" do
    test "accepts token_name and fetch_interval opts on start" do
      opts = [token_name: "Ticker", fetch_interval: 1_000]
      assert {:ok, _pid} = PriceServer.start_link(opts)
    end
  end

  describe "periodically updates token price according to fetch_interval option" do
    opts = [token_name: "ADA", fetch_interval: 10]
    assert {:ok, _pid} = PriceServer.start_link(opts)
    assert price = PriceServer.get_price("ADA")

    Process.sleep(15)

    assert updated_price = PriceServer.get_price("ADA")
    assert updated_price !== price
  end
end

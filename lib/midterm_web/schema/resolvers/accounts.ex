defmodule MidtermWeb.Resolvers.Accounts do
  alias Midterm.Accounts

  def get_account_by_address_hash(_parent, %{address_hash: address_hash}, _resolution) do
    Accounts.get_account_by_address_hash(address_hash)
  end
end

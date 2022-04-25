defmodule MidtermWeb.Resolvers.Accounts do
  alias Midterm.Accounts

  def get_account_by_address_hash(_parent, %{address_hash: address_hash}, %{context: context}) do
    case context do
      %{current_api_access: %{account: account}}
      when account.address_hash === address_hash ->
        Accounts.get_account_by_address_hash(address_hash)

      _ ->
        {:error, "unauthorized"}
    end
  end
end

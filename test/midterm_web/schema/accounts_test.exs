defmodule MidtermWeb.Schema.AccountsTest do
  use Midterm.DataCase, async: true

  import Midterm.AccountsFixtures
  alias MidtermWeb.Schema

  @account_by_address_hash_doc """
  query Account($address_hash: String!) {
    account(address_hash: $address_hash) {
      id
      address_hash
      alias
      credits
      email
      push_over_key
      sms
      status
    }
  }
  """

  describe "@account" do
    test "fetches an account by address_hash" do
      assert account = account_fixture()

      assert {:ok, %{data: data}} =
               Absinthe.run(@account_by_address_hash_doc, Schema,
                 variables: %{"address_hash" => account.address_hash}
               )

      account_res = data["account"]
      assert account_res["id"] === account.id
      assert account_res["address_hash"] === account.address_hash
      assert account_res["alias"] === account.alias
      assert account_res["credits"] === account.credits
      assert account_res["email"] === account.email
      assert account_res["push_over_key"] === account.push_over_key
      assert account_res["sms"] === account.sms
      assert account_res["status"] === Atom.to_string(account.status)
    end
  end
end

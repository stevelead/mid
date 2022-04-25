defmodule MidtermWeb.Schema.Queries.AccountsTest do
  use MidtermWeb.ConnCase, async: true

  import Midterm.AccountsFixtures
  alias Midterm.Accounts

  @account_by_address_hash_doc """
  query Account($address_hash: String!) {
    account(address_hash: $address_hash) {
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
    test "fetches an account with valid api_key" do
      assert {api_access, account} = fetch_api_key_and_account()

      conn = build_conn() |> auth_account(api_access)

      conn =
        post conn, "/api",
          query: @account_by_address_hash_doc,
          variables: %{"address_hash" => account.address_hash}

      assert json_response(conn, 200) == %{
               "data" => %{
                 "account" => %{
                   "address_hash" => account.address_hash,
                   "alias" => account.alias,
                   "credits" => account.credits,
                   "email" => account.email,
                   "push_over_key" => account.push_over_key,
                   "sms" => account.sms,
                   "status" => Atom.to_string(account.status)
                 }
               }
             }
    end

    test "does not fetch an account without valid api_key" do
      assert {api_access, account} = fetch_api_key_and_account()

      conn = build_conn()

      conn =
        post conn, "/api",
          query: @account_by_address_hash_doc,
          variables: %{"address_hash" => account.address_hash}

      assert %{
               "errors" => errors
             } = json_response(conn, 200)

      error_messages = errors |> Enum.map(&Map.get(&1, "message")) |> Enum.join()
      assert error_messages =~ "unauthorized"
    end

    test "does not fetch an account without incorrect api_key" do
      assert {api_access, account} = fetch_api_key_and_account()
      incorrect_api_access = Map.put(api_access, :api_key, "incorrect_key")

      conn = build_conn() |> auth_account(incorrect_api_access)

      conn =
        post conn, "/api",
          query: @account_by_address_hash_doc,
          variables: %{"address_hash" => account.address_hash}

      assert %{
               "errors" => errors
             } = json_response(conn, 200)

      error_messages = errors |> Enum.map(&Map.get(&1, "message")) |> Enum.join()
      assert error_messages =~ "unauthorized"
    end
  end

  defp fetch_api_key_and_account() do
    assert api_access = api_access_fixture()
    assert {:ok, account} = Accounts.get_account(%{api_access_id: api_access.id})
    {api_access, account}
  end
end

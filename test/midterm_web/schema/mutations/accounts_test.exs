defmodule MidtermWeb.Schema.Mutations.AccountsTest do
  use MidtermWeb.ConnCase, async: true

  import Midterm.AccountsFixtures

  @create_watched_address_doc """
  mutation CreateWatchedAddress($account_address_hash: String!, $watched_address_hash: String!, $name: String) {
    createWatchedAddress(account_address_hash: $account_address_hash, watched_address_hash: $watched_address_hash, name: $name) {
      address_hash
      name
    }
  }
  """

  describe "@createWatchedAddress" do
    test "creates a watched address with valid api_key" do
      assert account = account_fixture()
      assert api_access = api_access_fixture(%{account_id: account.id})

      watched_address_variables = %{
        "account_address_hash" => account.address_hash,
        "watched_address_hash" => "address_hash_for_createWatchedAddress",
        "name" => "name_for_createWatchedAddress"
      }

      conn = build_conn() |> auth_account(api_access)

      conn =
        post conn, "/api",
          query: @create_watched_address_doc,
          variables: watched_address_variables

      assert json_response(conn, 200) == %{
               "data" => %{
                 "createWatchedAddress" => %{
                   "address_hash" => watched_address_variables["watched_address_hash"],
                   "name" => watched_address_variables["name"]
                 }
               }
             }
    end

    test "does not create a watched address without a valid api_key" do
      assert account = account_fixture()

      watched_address_variables = %{
        "account_address_hash" => account.address_hash,
        "watched_address_hash" => "address_hash_for_createWatchedAddress",
        "name" => "name_for_createWatchedAddress"
      }

      conn = build_conn()

      conn =
        post conn, "/api",
          query: @create_watched_address_doc,
          variables: watched_address_variables

      assert %{
               "errors" => errors
             } = json_response(conn, 200)

      error_messages = errors |> Enum.map(&Map.get(&1, "message")) |> Enum.join()
      assert error_messages =~ "unauthorized"
    end
  end
end

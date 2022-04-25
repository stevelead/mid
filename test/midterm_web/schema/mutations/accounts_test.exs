defmodule MidtermWeb.Schema.Mutations.AccountsTest do
  use MidtermWeb.ConnCase, async: true

  import Midterm.AccountsFixtures
  alias Midterm.Accounts

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
      assert {api_access, account} = fetch_api_key_and_account()

      conn = build_conn() |> auth_account(api_access)

      watched_address_variables = get_watched_address_variables(account)

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
      assert {api_access, account} = fetch_api_key_and_account()
      incorrect_api_access = Map.put(api_access, :api_key, "incorrect_key")

      no_api_key_conn = build_conn()
      incorrect_api_key_conn = build_conn() |> auth_account(incorrect_api_access)

      watched_address_variables = get_watched_address_variables(account)

      for conn <- [no_api_key_conn, incorrect_api_key_conn] do
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

  defp get_watched_address_variables(account) do
    %{
      "account_address_hash" => account.address_hash,
      "watched_address_hash" => "address_hash_for_createWatchedAddress",
      "name" => "name_for_createWatchedAddress"
    }
  end

  defp fetch_api_key_and_account() do
    assert api_access = api_access_fixture()
    assert {:ok, account} = Accounts.get_account(%{api_access_id: api_access.id})
    {api_access, account}
  end
end

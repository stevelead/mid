defmodule Midterm.AccountsTest do
  use Midterm.DataCase, async: true

  alias Midterm.Accounts

  describe "accounts" do
    alias Midterm.Accounts.Account

    import Midterm.AccountsFixtures

    @invalid_attrs %{
      address_hash: nil,
      alias: nil,
      credits: nil,
      email: nil,
      push_over_key: nil,
      sms: nil,
      status: nil
    }

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{
        address_hash: "some address_hash",
        alias: "some alias",
        credits: 42,
        email: "some email",
        push_over_key: "some push_over_key",
        sms: "some sms",
        status: :active
      }

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.address_hash == "some address_hash"
      assert account.alias == "some alias"
      assert account.credits == 42
      assert account.email == "some email"
      assert account.push_over_key == "some push_over_key"
      assert account.sms == "some sms"
      assert account.status == :active
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()

      update_attrs = %{
        address_hash: "some updated address_hash",
        alias: "some updated alias",
        credits: 43,
        email: "some updated email",
        push_over_key: "some updated push_over_key",
        sms: "some updated sms",
        status: :paused
      }

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.address_hash == "some updated address_hash"
      assert account.alias == "some updated alias"
      assert account.credits == 43
      assert account.email == "some updated email"
      assert account.push_over_key == "some updated push_over_key"
      assert account.sms == "some updated sms"
      assert account.status == :paused
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end

  describe "watched_addresses" do
    alias Midterm.Accounts.WatchedAddress

    import Midterm.AccountsFixtures

    @invalid_attrs %{address_hash: nil}

    test "list_watched_addresses/0 returns all watched_addresses" do
      watched_address = watched_address_fixture()
      assert Accounts.list_watched_addresses() == [watched_address]
    end

    test "get_watched_address!/1 returns the watched_address with given id" do
      watched_address = watched_address_fixture()
      assert Accounts.get_watched_address!(watched_address.id) == watched_address
    end

    test "create_watched_address/1 with valid data creates a watched_address" do
      valid_attrs = %{address_hash: "some address_hash"}

      assert {:ok, %WatchedAddress{} = watched_address} =
               Accounts.create_watched_address(valid_attrs)

      assert watched_address.address_hash == "some address_hash"
    end

    test "create_watched_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_watched_address(@invalid_attrs)
    end

    test "update_watched_address/2 with valid data updates the watched_address" do
      watched_address = watched_address_fixture()
      update_attrs = %{address_hash: "some updated address_hash"}

      assert {:ok, %WatchedAddress{} = watched_address} =
               Accounts.update_watched_address(watched_address, update_attrs)

      assert watched_address.address_hash == "some updated address_hash"
    end

    test "update_watched_address/2 with invalid data returns error changeset" do
      watched_address = watched_address_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_watched_address(watched_address, @invalid_attrs)

      assert watched_address == Accounts.get_watched_address!(watched_address.id)
    end

    test "delete_watched_address/1 deletes the watched_address" do
      watched_address = watched_address_fixture()
      assert {:ok, %WatchedAddress{}} = Accounts.delete_watched_address(watched_address)

      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_watched_address!(watched_address.id)
      end
    end

    test "change_watched_address/1 returns a watched_address changeset" do
      watched_address = watched_address_fixture()
      assert %Ecto.Changeset{} = Accounts.change_watched_address(watched_address)
    end
  end

  describe "account_watched_addresses" do
    alias Midterm.Accounts.AccountWatchedAddress

    import Midterm.AccountsFixtures

    @invalid_attrs %{account_id: nil}

    test "list_account_watched_addresses/0 returns all account_watched_addresses" do
      account_watched_addresses =
        Enum.map(0..5, fn _n -> account_watched_address_fixture() end)
        |> Enum.map(&nillify_assocs(&1, [:account, :notification_preference]))

      result =
        Accounts.list_account_watched_addresses()
        |> Enum.map(&nillify_assocs(&1, [:account, :notification_preference]))

      assert result == account_watched_addresses
    end

    defp nillify_assocs(item, assocs_list) do
      Map.drop(item, assocs_list)
    end

    test "get_account_watched_address!/1 returns the account_watched_address with given id" do
      account_watched_address = account_watched_address_fixture()

      assert Accounts.get_account_watched_address!(account_watched_address.id) ==
               account_watched_address
    end

    test "create_account_watched_address/1 with valid data creates a account_watched_address" do
      account = account_fixture()
      watched_address = watched_address_fixture()

      valid_attrs = %{account_id: account.id, watched_address_id: watched_address.id}

      assert {:ok, %AccountWatchedAddress{} = _account_watched_address} =
               Accounts.create_account_watched_address(valid_attrs)
    end

    test "create_account_watched_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account_watched_address(@invalid_attrs)
    end

    test "update_account_watched_address/2 with valid data updates the account_watched_address" do
      account_watched_address = account_watched_address_fixture()
      update_attrs = %{}

      assert {:ok, %AccountWatchedAddress{} = _account_watched_address} =
               Accounts.update_account_watched_address(account_watched_address, update_attrs)
    end

    test "update_account_watched_address/2 with invalid data returns error changeset" do
      account_watched_address = account_watched_address_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_account_watched_address(account_watched_address, @invalid_attrs)

      assert account_watched_address ==
               Accounts.get_account_watched_address!(account_watched_address.id)
    end

    test "delete_account_watched_address/1 deletes the account_watched_address" do
      account_watched_address = account_watched_address_fixture()

      assert {:ok, %AccountWatchedAddress{}} =
               Accounts.delete_account_watched_address(account_watched_address)

      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_account_watched_address!(account_watched_address.id)
      end
    end

    test "change_account_watched_address/1 returns a account_watched_address changeset" do
      account_watched_address = account_watched_address_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account_watched_address(account_watched_address)
    end
  end

  describe "notification_preferences" do
    alias Midterm.Accounts.NotificationPreference

    import Midterm.AccountsFixtures

    @invalid_attrs %{
      devices_to_notify: nil,
      limit_by_type: nil,
      values_greater_than: nil,
      account_watched_address_id: nil
    }

    test "list_notification_preferences/0 returns all notification_preferences" do
      notification_preference = notification_preference_fixture()
      assert Accounts.list_notification_preferences() == [notification_preference]
    end

    test "get_notification_preference!/1 returns the notification_preference with given id" do
      notification_preference = notification_preference_fixture()

      assert Accounts.get_notification_preference!(notification_preference.id) ==
               notification_preference
    end

    test "create_notification_preference/1 with valid data creates a notification_preference" do
      account_watched_address = account_watched_address_fixture()

      valid_attrs = %{
        devices_to_notify: [],
        limit_by_type: :received,
        values_greater_than: 42,
        account_watched_address_id: account_watched_address.id
      }

      assert {:ok, %NotificationPreference{} = notification_preference} =
               Accounts.create_notification_preference(valid_attrs)

      assert notification_preference.devices_to_notify == []
      assert notification_preference.limit_by_type == :received
      assert notification_preference.values_greater_than == 42
    end

    test "create_notification_preference/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_notification_preference(@invalid_attrs)
    end

    test "update_notification_preference/2 with valid data updates the notification_preference" do
      notification_preference = notification_preference_fixture()
      update_attrs = %{devices_to_notify: [], limit_by_type: :spent, values_greater_than: 43}

      assert {:ok, %NotificationPreference{} = notification_preference} =
               Accounts.update_notification_preference(notification_preference, update_attrs)

      assert notification_preference.devices_to_notify == []
      assert notification_preference.limit_by_type == :spent
      assert notification_preference.values_greater_than == 43
    end

    test "update_notification_preference/2 with invalid data returns error changeset" do
      notification_preference = notification_preference_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_notification_preference(notification_preference, @invalid_attrs)

      assert notification_preference ==
               Accounts.get_notification_preference!(notification_preference.id)
    end

    test "delete_notification_preference/1 deletes the notification_preference" do
      notification_preference = notification_preference_fixture()

      assert {:ok, %NotificationPreference{}} =
               Accounts.delete_notification_preference(notification_preference)

      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_notification_preference!(notification_preference.id)
      end
    end

    test "change_notification_preference/1 returns a notification_preference changeset" do
      notification_preference = notification_preference_fixture()
      assert %Ecto.Changeset{} = Accounts.change_notification_preference(notification_preference)
    end
  end

  describe "credit_purchases" do
    alias Midterm.Accounts.CreditPurchase

    import Midterm.AccountsFixtures

    @invalid_attrs %{credits_purchased: nil, purchase_cost: nil, purchase_currency: nil}

    test "list_credit_purchases/0 returns all credit_purchases" do
      credit_purchase = credit_purchase_fixture()
      assert Accounts.list_credit_purchases() == [credit_purchase]
    end

    test "get_credit_purchase!/1 returns the credit_purchase with given id" do
      credit_purchase = credit_purchase_fixture()
      assert Accounts.get_credit_purchase!(credit_purchase.id) == credit_purchase
    end

    test "create_credit_purchase/1 with valid data creates a credit_purchase" do
      account = account_fixture()

      valid_attrs = %{
        credits_purchased: 42,
        purchase_cost: 42,
        purchase_currency: :ada,
        account_id: account.id
      }

      assert {:ok, %CreditPurchase{} = credit_purchase} =
               Accounts.create_credit_purchase(valid_attrs)

      assert credit_purchase.credits_purchased == 42
      assert credit_purchase.purchase_cost == 42
      assert credit_purchase.purchase_currency == :ada
    end

    test "create_credit_purchase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_credit_purchase(@invalid_attrs)
    end

    test "update_credit_purchase/2 with valid data updates the credit_purchase" do
      credit_purchase = credit_purchase_fixture()
      update_attrs = %{credits_purchased: 43, purchase_cost: 43, purchase_currency: :ada}

      assert {:ok, %CreditPurchase{} = credit_purchase} =
               Accounts.update_credit_purchase(credit_purchase, update_attrs)

      assert credit_purchase.credits_purchased == 43
      assert credit_purchase.purchase_cost == 43
      assert credit_purchase.purchase_currency == :ada
    end

    test "update_credit_purchase/2 with invalid data returns error changeset" do
      credit_purchase = credit_purchase_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_credit_purchase(credit_purchase, @invalid_attrs)

      assert credit_purchase == Accounts.get_credit_purchase!(credit_purchase.id)
    end

    test "delete_credit_purchase/1 deletes the credit_purchase" do
      credit_purchase = credit_purchase_fixture()
      assert {:ok, %CreditPurchase{}} = Accounts.delete_credit_purchase(credit_purchase)

      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_credit_purchase!(credit_purchase.id)
      end
    end

    test "change_credit_purchase/1 returns a credit_purchase changeset" do
      credit_purchase = credit_purchase_fixture()
      assert %Ecto.Changeset{} = Accounts.change_credit_purchase(credit_purchase)
    end
  end

  describe "api_access" do
    alias Midterm.Accounts.ApiAccess

    import Midterm.AccountsFixtures

    @invalid_attrs %{api_key: nil, status: nil, valid_until: nil}

    test "list_api_access/0 returns all api_access" do
      api_access = api_access_fixture()
      assert Accounts.list_api_access() == [api_access]
    end

    test "get_api_access!/1 returns the api_access with given id" do
      api_access = api_access_fixture()
      assert Accounts.get_api_access!(api_access.id) == api_access
    end

    test "create_api_access/1 with valid data creates a api_access" do
      account = account_fixture()

      valid_attrs = %{
        api_key: "some api_key",
        status: :active,
        valid_until: ~U[2022-04-23 22:00:00Z],
        account_id: account.id
      }

      assert {:ok, %ApiAccess{} = api_access} = Accounts.create_api_access(valid_attrs)
      assert api_access.api_key == "some api_key"
      assert api_access.status == :active
      assert api_access.valid_until == ~U[2022-04-23 22:00:00Z]
    end

    test "create_api_access/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_api_access(@invalid_attrs)
    end

    test "update_api_access/2 with valid data updates the api_access" do
      api_access = api_access_fixture()

      update_attrs = %{
        api_key: "some updated api_key",
        status: :paused,
        valid_until: ~U[2022-04-24 22:00:00Z]
      }

      assert {:ok, %ApiAccess{} = api_access} =
               Accounts.update_api_access(api_access, update_attrs)

      assert api_access.api_key == "some updated api_key"
      assert api_access.status == :paused
      assert api_access.valid_until == ~U[2022-04-24 22:00:00Z]
    end

    test "update_api_access/2 with invalid data returns error changeset" do
      api_access = api_access_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_api_access(api_access, @invalid_attrs)
      assert api_access == Accounts.get_api_access!(api_access.id)
    end

    test "delete_api_access/1 deletes the api_access" do
      api_access = api_access_fixture()
      assert {:ok, %ApiAccess{}} = Accounts.delete_api_access(api_access)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_api_access!(api_access.id) end
    end

    test "change_api_access/1 returns a api_access changeset" do
      api_access = api_access_fixture()
      assert %Ecto.Changeset{} = Accounts.change_api_access(api_access)
    end
  end
end

defmodule Midterm.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Midterm.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        address_hash: "some address_hash",
        alias: "some alias",
        credits: 42,
        email: "some email",
        push_over_key: "some push_over_key",
        sms: "some sms",
        status: :active
      })
      |> Midterm.Accounts.create_account()

    account
  end

  @doc """
  Generate a unique watched_address address_hash.
  """
  def unique_watched_address_address_hash, do: "some address_hash#{System.unique_integer([:positive])}"

  @doc """
  Generate a watched_address.
  """
  def watched_address_fixture(attrs \\ %{}) do
    {:ok, watched_address} =
      attrs
      |> Enum.into(%{
        address_hash: unique_watched_address_address_hash()
      })
      |> Midterm.Accounts.create_watched_address()

    watched_address
  end

  @doc """
  Generate a account_watched_address.
  """
  def account_watched_address_fixture(attrs \\ %{}) do
    {:ok, account_watched_address} =
      attrs
      |> Enum.into(%{

      })
      |> Midterm.Accounts.create_account_watched_address()

    account_watched_address
  end

  @doc """
  Generate a notification_preference.
  """
  def notification_preference_fixture(attrs \\ %{}) do
    {:ok, notification_preference} =
      attrs
      |> Enum.into(%{
        devices_to_notify: [],
        limit_by_type: :received,
        values_greater_than: 42
      })
      |> Midterm.Accounts.create_notification_preference()

    notification_preference
  end

  @doc """
  Generate a credit_purchase.
  """
  def credit_purchase_fixture(attrs \\ %{}) do
    {:ok, credit_purchase} =
      attrs
      |> Enum.into(%{
        credits_purchased: 42,
        purchase_cost: 42,
        purchase_currency: :ada
      })
      |> Midterm.Accounts.create_credit_purchase()

    credit_purchase
  end

  @doc """
  Generate a unique api_access api_code.
  """
  def unique_api_access_api_code, do: "some api_code#{System.unique_integer([:positive])}"

  @doc """
  Generate a api_access.
  """
  def api_access_fixture(attrs \\ %{}) do
    {:ok, api_access} =
      attrs
      |> Enum.into(%{
        api_code: unique_api_access_api_code(),
        status: :active,
        valid_until: ~U[2022-04-23 22:00:00Z]
      })
      |> Midterm.Accounts.create_api_access()

    api_access
  end
end

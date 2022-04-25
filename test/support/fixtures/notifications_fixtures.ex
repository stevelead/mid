defmodule Midterm.NotificationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Midterm.Notifications` context.
  """

  import Midterm.DataFeedFixtures, only: [block_fixture: 0]
  import Midterm.AccountsFixtures, only: [account_watched_address_fixture: 0]

  @doc """
  Generate a notification_type.
  """
  def notification_type_fixture(attrs \\ %{}) do
    {:ok, notification_type} =
      attrs
      |> Enum.into(%{
        type: "some type"
      })
      |> Midterm.Notifications.create_notification_type()

    notification_type
  end

  @doc """
  Generate a notification.
  """
  def notification_fixture(attrs \\ %{}) do
    notification_type = notification_type_fixture()
    account_watched_address = account_watched_address_fixture()
    block = block_fixture()

    {:ok, notification} =
      attrs
      |> Enum.into(%{
        credits_spent: 42,
        notification_datails: %{},
        notification_type_id: notification_type.id,
        account_watched_address_id: account_watched_address.id,
        block_id: block.id
      })
      |> Midterm.Notifications.create_notification()

    notification
  end
end

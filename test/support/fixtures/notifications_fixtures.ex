defmodule Midterm.NotificationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Midterm.Notifications` context.
  """

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
    {:ok, notification} =
      attrs
      |> Enum.into(%{
        credits_spent: 42,
        notification_datails: %{}
      })
      |> Midterm.Notifications.create_notification()

    notification
  end
end

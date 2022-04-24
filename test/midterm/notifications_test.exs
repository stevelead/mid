defmodule Midterm.NotificationsTest do
  use Midterm.DataCase

  alias Midterm.Notifications

  describe "notification_types" do
    alias Midterm.Notifications.NotificationType

    import Midterm.NotificationsFixtures

    @invalid_attrs %{type: nil}

    test "list_notification_types/0 returns all notification_types" do
      notification_type = notification_type_fixture()
      assert Notifications.list_notification_types() == [notification_type]
    end

    test "get_notification_type!/1 returns the notification_type with given id" do
      notification_type = notification_type_fixture()
      assert Notifications.get_notification_type!(notification_type.id) == notification_type
    end

    test "create_notification_type/1 with valid data creates a notification_type" do
      valid_attrs = %{type: "some type"}

      assert {:ok, %NotificationType{} = notification_type} = Notifications.create_notification_type(valid_attrs)
      assert notification_type.type == "some type"
    end

    test "create_notification_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notifications.create_notification_type(@invalid_attrs)
    end

    test "update_notification_type/2 with valid data updates the notification_type" do
      notification_type = notification_type_fixture()
      update_attrs = %{type: "some updated type"}

      assert {:ok, %NotificationType{} = notification_type} = Notifications.update_notification_type(notification_type, update_attrs)
      assert notification_type.type == "some updated type"
    end

    test "update_notification_type/2 with invalid data returns error changeset" do
      notification_type = notification_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Notifications.update_notification_type(notification_type, @invalid_attrs)
      assert notification_type == Notifications.get_notification_type!(notification_type.id)
    end

    test "delete_notification_type/1 deletes the notification_type" do
      notification_type = notification_type_fixture()
      assert {:ok, %NotificationType{}} = Notifications.delete_notification_type(notification_type)
      assert_raise Ecto.NoResultsError, fn -> Notifications.get_notification_type!(notification_type.id) end
    end

    test "change_notification_type/1 returns a notification_type changeset" do
      notification_type = notification_type_fixture()
      assert %Ecto.Changeset{} = Notifications.change_notification_type(notification_type)
    end
  end

  describe "notifications" do
    alias Midterm.Notifications.Notification

    import Midterm.NotificationsFixtures

    @invalid_attrs %{credits_spent: nil, notification_datails: nil}

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Notifications.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Notifications.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      valid_attrs = %{credits_spent: 42, notification_datails: %{}}

      assert {:ok, %Notification{} = notification} = Notifications.create_notification(valid_attrs)
      assert notification.credits_spent == 42
      assert notification.notification_datails == %{}
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notifications.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      update_attrs = %{credits_spent: 43, notification_datails: %{}}

      assert {:ok, %Notification{} = notification} = Notifications.update_notification(notification, update_attrs)
      assert notification.credits_spent == 43
      assert notification.notification_datails == %{}
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Notifications.update_notification(notification, @invalid_attrs)
      assert notification == Notifications.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Notifications.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Notifications.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Notifications.change_notification(notification)
    end
  end
end

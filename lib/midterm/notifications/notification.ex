defmodule Midterm.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Notifications.NotificationType
  alias Midterm.Accounts.AccountWatchedAddress
  alias Midterm.DataFeed.Block

  schema "notifications" do
    field :credits_spent, :integer
    field :notification_datails, :map

    field :notification_type_id, NotificationType
    field :account_watched_address_id, AccountWatchedAddress
    field :block_id, Block

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:credits_spent, :notification_datails])
    |> validate_required([:credits_spent, :notification_datails])
  end
end

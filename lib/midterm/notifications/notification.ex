defmodule Midterm.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Notifications.NotificationType
  alias Midterm.Accounts.AccountWatchedAddress
  alias Midterm.DataFeed.Block

  schema "notifications" do
    field :credits_spent, :integer
    field :notification_datails, :map

    belongs_to :notification_type, NotificationType
    belongs_to :account_watched_address, AccountWatchedAddress
    belongs_to :block, Block

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:credits_spent, :notification_datails])
    |> validate_required([:credits_spent, :notification_datails])
  end
end

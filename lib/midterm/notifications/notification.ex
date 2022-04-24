defmodule Midterm.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :credits_spent, :integer
    field :notification_datails, :map
    field :notification_type_id, :id
    field :account_watched_addresses_id, :id
    field :block_id, :id

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:credits_spent, :notification_datails])
    |> validate_required([:credits_spent, :notification_datails])
  end
end

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

  @required_parameters [
    :credits_spent,
    :notification_datails,
    :notification_type_id,
    :account_watched_address_id,
    :block_id
  ]

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, @required_parameters)
    |> validate_required(@required_parameters)
  end
end

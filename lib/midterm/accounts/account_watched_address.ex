defmodule Midterm.Accounts.AccountWatchedAddress do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Accounts.Account
  alias Midterm.Accounts.WatchedAddress
  alias Midterm.Accounts.NotificationPreference
  alias Midterm.Notifications.Notification

  schema "account_watched_addresses" do
    belongs_to :account, Account
    belongs_to :watched_address, WatchedAddress

    has_one :notification_preference, NotificationPreference
    has_many :notifications, Notification

    timestamps()
  end

  @required_parameters [:account_id, :watched_address_id]
  @available_parameters @required_parameters

  @doc false
  def changeset(account_watched_address, attrs) do
    account_watched_address
    |> cast(attrs, @available_parameters)
    |> validate_required(@required_parameters)
  end
end

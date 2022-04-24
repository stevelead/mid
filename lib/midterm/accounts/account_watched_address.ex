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

  @doc false
  def changeset(account_watched_address, attrs) do
    account_watched_address
    |> cast(attrs, [])
    |> validate_required([])
  end
end

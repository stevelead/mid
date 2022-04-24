defmodule Midterm.Accounts.NotificationPreference do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Accounts.AccountWatchedAddress

  schema "notification_preferences" do
    field :devices_to_notify, {:array, :string}
    field :limit_by_type, Ecto.Enum, values: [:received, :spent, :all]
    field :values_greater_than, :integer

    belongs_to :account_watched_address, AccountWatchedAddress

    timestamps()
  end

  @doc false
  def changeset(notification_preference, attrs) do
    notification_preference
    |> cast(attrs, [:limit_by_type, :values_greater_than, :devices_to_notify])
    |> validate_required([:limit_by_type, :values_greater_than, :devices_to_notify])
  end
end

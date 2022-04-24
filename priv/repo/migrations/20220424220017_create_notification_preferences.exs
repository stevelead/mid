defmodule Midterm.Repo.Migrations.CreateNotificationPreferences do
  use Ecto.Migration

  def change do
    create table(:notification_preferences) do
      add :limit_by_type, :string
      add :values_greater_than, :integer
      add :devices_to_notify, {:array, :string}
      add :account_watched_address_id, references(:account_watched_addresses, on_delete: :nothing)

      timestamps()
    end

    create index(:notification_preferences, [:accounts_watched_address_id])
  end
end

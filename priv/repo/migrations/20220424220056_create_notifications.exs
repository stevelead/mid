defmodule Midterm.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :credits_spent, :integer
      add :notification_datails, :map
      add :notification_type_id, references(:notification_types, on_delete: :nothing)
      add :account_watched_addresses_id, references(:account_watched_addresses, on_delete: :nothing)
      add :block_id, references(:blocks, on_delete: :nothing)

      timestamps()
    end

    create index(:notifications, [:notification_type_id])
    create index(:notifications, [:account_watched_addresses_id])
    create index(:notifications, [:block_id])
  end
end

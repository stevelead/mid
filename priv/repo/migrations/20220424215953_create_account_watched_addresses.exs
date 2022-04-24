defmodule Midterm.Repo.Migrations.CreateAccountWatchedAddresses do
  use Ecto.Migration

  def change do
    create table(:account_watched_addresses) do
      add :account_id, references(:accounts, on_delete: :nothing)
      add :watched_address_id, references(:watched_addresses, on_delete: :nothing)

      timestamps()
    end

    create index(:account_watched_addresses, [:account_id])
    create index(:account_watched_addresses, [:watched_address_id])
    create unique_index(:account_watched_addresses, [:account_id, :watched_address_id])
  end
end

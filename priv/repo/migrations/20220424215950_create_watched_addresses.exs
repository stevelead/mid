defmodule Midterm.Repo.Migrations.CreateWatchedAddresses do
  use Ecto.Migration

  def change do
    create table(:watched_addresses) do
      add :address_hash, :string

      timestamps()
    end

    create unique_index(:watched_addresses, [:address_hash])
  end
end

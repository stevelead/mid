defmodule Midterm.Repo.Migrations.CreateApiAccess do
  use Ecto.Migration

  def change do
    create table(:api_access) do
      add :api_code, :string
      add :status, :string
      add :valid_until, :utc_datetime
      add :account_id, references(:accounts, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:api_access, [:api_code])
    create index(:api_access, [:account_id])
  end
end

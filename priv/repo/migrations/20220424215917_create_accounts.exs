defmodule Midterm.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :address_hash, :string
      add :credits, :integer
      add :alias, :string
      add :email, :string
      add :sms, :string
      add :push_over_key, :string
      add :status, :string

      timestamps()
    end
  end
end

defmodule Midterm.Repo.Migrations.CreateCreditPurchases do
  use Ecto.Migration

  def change do
    create table(:credit_purchases) do
      add :credits_purchased, :integer
      add :purchase_cost, :integer
      add :purchase_currency, :string
      add :account_id, references(:accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:credit_purchases, [:account_id])
  end
end

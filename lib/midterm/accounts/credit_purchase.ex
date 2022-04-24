defmodule Midterm.Accounts.CreditPurchase do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Accounts.Account

  schema "credit_purchases" do
    field :credits_purchased, :integer
    field :purchase_cost, :integer
    field :purchase_currency, Ecto.Enum, values: [:ada]

    belongs_to :account, Account

    timestamps()
  end

  @doc false
  def changeset(credit_purchase, attrs) do
    credit_purchase
    |> cast(attrs, [:credits_purchased, :purchase_cost, :purchase_currency])
    |> validate_required([:credits_purchased, :purchase_cost, :purchase_currency])
  end
end

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

  @required_parameters [:credits_purchased, :purchase_cost, :account_id]
  @available_parameters [:purchase_currency | @required_parameters]

  @doc false
  def changeset(credit_purchase, attrs) do
    credit_purchase
    |> cast(attrs, @available_parameters)
    |> validate_required(@required_parameters)
  end
end

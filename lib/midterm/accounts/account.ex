defmodule Midterm.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :address_hash, :string
    field :alias, :string
    field :credits, :integer
    field :email, :string
    field :push_over_key, :string
    field :sms, :string
    field :status, Ecto.Enum, values: [:active, :paused, :cancelled]

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:address_hash, :credits, :alias, :email, :sms, :push_over_key, :status])
    |> validate_required([:address_hash, :credits, :alias, :email, :sms, :push_over_key, :status])
  end
end

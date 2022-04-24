defmodule Midterm.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Accounts.AccountWatchedAddress
  alias Midterm.Accounts.CreditPurchase
  alias Midterm.Accounts.ApiAccess

  schema "accounts" do
    field :address_hash, :string
    field :alias, :string
    field :credits, :integer
    field :email, :string
    field :push_over_key, :string
    field :sms, :string
    field :status, Ecto.Enum, values: [:active, :paused, :cancelled]

    has_many :account_watched_addresses, AccountWatchedAddress
    has_many :credit_purchases, CreditPurchase
    has_one :api_access, ApiAccess

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:address_hash, :credits, :alias, :email, :sms, :push_over_key, :status])
    |> validate_required([:address_hash, :credits, :alias, :email, :sms, :push_over_key, :status])
  end
end

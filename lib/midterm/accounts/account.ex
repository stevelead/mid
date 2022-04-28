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
    field :status, Ecto.Enum, values: [:active, :paused, :cancelled], default: :active

    has_many :account_watched_addresses, AccountWatchedAddress
    has_many :credit_purchases, CreditPurchase
    has_one :api_access, ApiAccess

    timestamps()
  end

  @required_parameters [:address_hash, :status]
  @available_parameters [:alias, :credits, :email, :sms, :push_over_key | @required_parameters]

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, @available_parameters)
    |> validate_required(@required_parameters)
    |> cast_assoc(:api_access)
  end
end

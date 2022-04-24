defmodule Midterm.Accounts.WatchedAddress do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Accounts.AccountWatchedAddress

  schema "watched_addresses" do
    field :address_hash, :string

    has_many :account_watched_addresses, AccountWatchedAddress

    timestamps()
  end

  @required_parameters [:address_hash]

  @doc false
  def changeset(watched_address, attrs) do
    watched_address
    |> cast(attrs, @required_parameters)
    |> validate_required(@required_parameters)
    |> unique_constraint(:address_hash)
  end
end

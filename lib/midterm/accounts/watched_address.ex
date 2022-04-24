defmodule Midterm.Accounts.WatchedAddress do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Accounts.AccountWatchedAddress

  schema "watched_addresses" do
    field :address_hash, :string

    has_many :account_watched_addresses, AccountWatchedAddress

    timestamps()
  end

  @doc false
  def changeset(watched_address, attrs) do
    watched_address
    |> cast(attrs, [:address_hash])
    |> validate_required([:address_hash])
    |> unique_constraint(:address_hash)
  end
end

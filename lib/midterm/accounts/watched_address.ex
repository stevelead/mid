defmodule Midterm.Accounts.WatchedAddress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "watched_addresses" do
    field :address_hash, :string

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

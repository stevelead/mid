defmodule Midterm.Accounts.AccountWatchedAddress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "account_watched_addresses" do

    field :account_id, :id
    field :watched_address_id, :id

    timestamps()
  end

  @doc false
  def changeset(account_watched_address, attrs) do
    account_watched_address
    |> cast(attrs, [])
    |> validate_required([])
  end
end

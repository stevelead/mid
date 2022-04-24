defmodule Midterm.Accounts.ApiAccess do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Accounts.Account

  schema "api_access" do
    field :api_code, :string
    field :status, Ecto.Enum, values: [:active, :paused, :cancelled]
    field :valid_until, :utc_datetime

    belongs_to :account, Account

    timestamps()
  end

  @doc false
  def changeset(api_access, attrs) do
    api_access
    |> cast(attrs, [:api_code, :status, :valid_until])
    |> validate_required([:api_code, :status, :valid_until])
    |> unique_constraint(:api_code)
  end
end

defmodule Midterm.Accounts.ApiAccess do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Accounts.Account

  schema "api_access" do
    field :api_key, :string
    field :status, Ecto.Enum, values: [:active, :paused, :cancelled]
    field :valid_until, :utc_datetime

    belongs_to :account, Account

    timestamps()
  end

  @required_parameters [:api_key, :status, :valid_until, :account_id]

  @doc false
  def changeset(api_access, attrs) do
    api_access
    |> cast(attrs, @required_parameters)
    |> validate_required(@required_parameters)
    |> unique_constraint(:api_key)
  end
end

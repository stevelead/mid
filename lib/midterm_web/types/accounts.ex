defmodule MidtermWeb.Types.Accounts do
  use Absinthe.Schema.Notation

  @desc "An account"
  object :account do
    field :id, :integer
    field :address_hash, :string
    field :alias, :string
    field :credits, :integer
    field :email, :string
    field :push_over_key, :string
    field :sms, :string
    field :status, :string
  end
end

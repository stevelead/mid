defmodule MidtermWeb.Queries.Accounts do
  use Absinthe.Schema.Notation

  alias MidtermWeb.Resolvers

  object :accounts_queries do
    @desc "An account"
    field :account, :account do
      arg :address_hash, :string
      # arg :alias, :string

      resolve &Resolvers.Accounts.get_account_by_address_hash/3
    end
  end
end

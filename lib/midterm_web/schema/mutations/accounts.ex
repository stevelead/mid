defmodule MidtermWeb.Mutations.Accounts do
  use Absinthe.Schema.Notation

  alias MidtermWeb.Resolvers

  object :accounts_mutations do
    @desc "Creates a watched address"
    field :create_watched_address, :watched_address do
      arg :account_address_hash, non_null(:string)
      arg :watched_address_hash, non_null(:string)
      arg :name, :string

      resolve &Resolvers.Accounts.create_watched_address/3
    end

    @desc "Resets an api key"
    field :reset_api_key, :api_access do
      arg :account_address_hash, non_null(:string)

      resolve &Resolvers.Accounts.reset_api_key/3
    end
  end
end

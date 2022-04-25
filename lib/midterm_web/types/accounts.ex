defmodule MidtermWeb.Types.Accounts do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "An account"
  object :account do
    field :address_hash, :string
    field :alias, :string
    field :credits, :integer
    field :email, :string
    field :push_over_key, :string
    field :sms, :string
    field :status, :string

    field :accounts_watched_addresses, list_of(:account_watched_address),
      do: resolve(dataloader(WmtRepo))

    field :api_access, :api_access, do: resolve(dataloader(WmtRepo))
    field :credit_purchases, list_of(:credit_purchase), do: resolve(dataloader(WmtRepo))
  end

  @desc "A watched address for an account"
  object :account_watched_address do
    field :account, :account, do: resolve(dataloader(WmtRepo))
    field :watched_address, :watched_address, do: resolve(dataloader(WmtRepo))

    field :notification_preference, :notification_preference, do: resolve(dataloader(WmtRepo))
    field :notifications, list_of(:notification), do: resolve(dataloader(WmtRepo))
  end

  @desc "A watched address"
  object :watched_address do
    field :address_hash, :string
  end

  @desc "Notification preferences for an account's watched address"
  object :notification_preference do
    field :devices_to_notify, list_of(:string)
    field :limit_by_type, :string
    field :values_greater_than, :integer

    field :account_watched_address, :account_watched_address, do: resolve(dataloader(WmtRepo))
  end

  @desc "Api access details"
  object :api_access do
    field :api_code, :string
    field :status, :string
    field :valid_until, :datetime

    field :account, :account, do: resolve(dataloader(WmtRepo))
  end

  @desc "A credit purchase"
  object :credit_purchase do
    field :credits_purchased, :integer
    field :purchase_cost, :integer
    field :purchase_currency, :string

    field :account, :account, do: resolve(dataloader(WmtRepo))
  end
end

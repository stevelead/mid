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
      do: resolve(dataloader(MidtermWebRepo))

    field :api_access, :api_access, do: resolve(dataloader(MidtermWebRepo))
    field :credit_purchases, list_of(:credit_purchase), do: resolve(dataloader(MidtermWebRepo))
  end

  @desc "A watched address for an account"
  object :account_watched_address do
    field :account, :account, do: resolve(dataloader(MidtermWebRepo))
    field :watched_address, :watched_address, do: resolve(dataloader(MidtermWebRepo))

    field :notification_preference, :notification_preference,
      do: resolve(dataloader(MidtermWebRepo))

    field :notifications, list_of(:notification), do: resolve(dataloader(MidtermWebRepo))
  end

  @desc "A watched address"
  object :watched_address do
    field :address_hash, :string
    field :name, :string
  end

  @desc "Notification preferences for an account's watched address"
  object :notification_preference do
    field :devices_to_notify, list_of(:string)
    field :limit_by_type, :string
    field :values_greater_than, :integer

    field :account_watched_address, :account_watched_address,
      do: resolve(dataloader(MidtermWebRepo))
  end

  @desc "Input object for notification preferences"
  input_object :notification_preferences_input do
    field :devices_to_notify, list_of(:string)
    field :limit_by_type, :string
    field :values_greater_than, :integer
  end

  @desc "Api access details"
  object :api_access do
    field :api_key, :string
    field :status, :string
    field :valid_until, :datetime

    field :account, :account, do: resolve(dataloader(MidtermWebRepo))
  end

  @desc "A credit purchase"
  object :credit_purchase do
    field :credits_purchased, :integer
    field :purchase_cost, :integer
    field :purchase_currency, :string

    field :account, :account, do: resolve(dataloader(MidtermWebRepo))
  end
end

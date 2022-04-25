defmodule MidtermWeb.Types.Notifications do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "A notification"
  object :notification do
    field :credits_spent, :integer
    field :notification_datails, :json

    field :notification_type, :notification_type, do: resolve(dataloader(WmtRepo))
    field :account_watched_address, :account_watched_address, do: resolve(dataloader(WmtRepo))
    field :block, :block, do: resolve(dataloader(WmtRepo))
  end

  @desc "A notification type"
  object :notification_type do
    field :type, :string

    field :notification, :notification, do: resolve(dataloader(WmtRepo))
  end
end

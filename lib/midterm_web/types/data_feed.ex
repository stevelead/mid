defmodule MidtermWeb.Types.DataFeed do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "A block"
  object :block do
    field :header_hash, :string
    field :slot, :integer
    field :rolled_back, :boolean

    field :notifications, list_of(:notification), do: resolve(dataloader(WmtRepo))
  end
end

defmodule MidtermWeb.Types.DataFeed do
  use Absinthe.Schema.Notation

  @desc "A block"
  object :block do
    field :header_hash, :string
    field :slot, :integer
    field :rolled_back, :boolean
  end
end

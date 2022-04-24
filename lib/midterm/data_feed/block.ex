defmodule Midterm.DataFeed.Block do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Notifications.Notification

  schema "blocks" do
    field :header_hash, :string
    field :rolled_back, :boolean, default: false
    field :slot, :integer
    field :received_block_id, :integer

    has_many :notifications, Notification

    timestamps()
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:header_hash, :slot, :rolled_back, :received_block_id])
    |> validate_required([:header_hash, :slot, :rolled_back, :received_block_id])
    |> unique_constraint(:slot)
    |> unique_constraint(:header_hash)
  end
end

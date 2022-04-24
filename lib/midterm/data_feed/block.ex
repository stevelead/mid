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

  @required_parameters [:header_hash, :slot, :received_block_id]
  @available_parameters [:rolled_back | @required_parameters]

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, @available_parameters)
    |> validate_required(@required_parameters)
    |> unique_constraint(:slot)
    |> unique_constraint(:header_hash)
  end
end

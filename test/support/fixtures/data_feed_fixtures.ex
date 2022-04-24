defmodule Midterm.DataFeedFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Midterm.DataFeed` context.
  """

  @doc """
  Generate a unique block header_hash.
  """
  def unique_block_header_hash, do: "some header_hash#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique block slot.
  """
  def unique_block_slot, do: System.unique_integer([:positive])

  @doc """
  Generate a block.
  """
  def block_fixture(attrs \\ %{}) do
    {:ok, block} =
      attrs
      |> Enum.into(%{
        header_hash: unique_block_header_hash(),
        received_block_id: 42,
        rolled_back: true,
        slot: unique_block_slot()
      })
      |> Midterm.DataFeed.create_block()

    block
  end
end

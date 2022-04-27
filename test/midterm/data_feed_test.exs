defmodule Midterm.DataFeedTest do
  use Midterm.DataCase

  alias Midterm.DataFeed

  describe "data feed" do
    alias Midterm.DataFeed

    test "add_address/1 returns :ok tuple" do
      assert {:ok, "123"} == DataFeed.add_address("123")
    end

    test "add_address/1 returns an error if not passed a string as address" do
      assert {:error, message} = DataFeed.add_address(123)
      assert message =~ "type"
    end

    test "remove_address/1 returns :ok tuple" do
      assert {:ok, "123"} == DataFeed.remove_address("123")
    end

    test "remove_address/1 returns an error if not passed a string as address" do
      assert {:error, message} = DataFeed.remove_address(123)
      assert message =~ "type"
    end
  end

  describe "blocks" do
    alias Midterm.DataFeed.Block

    import Midterm.DataFeedFixtures

    @invalid_attrs %{header_hash: nil, received_block_id: nil, rolled_back: nil, slot: nil}

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert DataFeed.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert DataFeed.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      valid_attrs = %{
        header_hash: "some header_hash",
        received_block_id: 42,
        rolled_back: true,
        slot: 42
      }

      assert {:ok, %Block{} = block} = DataFeed.create_block(valid_attrs)
      assert block.header_hash == "some header_hash"
      assert block.received_block_id == 42
      assert block.rolled_back == true
      assert block.slot == 42
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DataFeed.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()

      update_attrs = %{
        header_hash: "some updated header_hash",
        received_block_id: 43,
        rolled_back: false,
        slot: 43
      }

      assert {:ok, %Block{} = block} = DataFeed.update_block(block, update_attrs)
      assert block.header_hash == "some updated header_hash"
      assert block.received_block_id == 43
      assert block.rolled_back == false
      assert block.slot == 43
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = DataFeed.update_block(block, @invalid_attrs)
      assert block == DataFeed.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = DataFeed.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> DataFeed.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = DataFeed.change_block(block)
    end
  end
end

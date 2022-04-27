defmodule Midterm.DataFeed do
  @moduledoc """
  The DataFeed context.
  """

  import Ecto.Query, warn: false
  alias Midterm.Repo

  alias Midterm.DataFeed.Block
  alias Midterm.DataFeed.HttpRequest

  @doc """
  Midterm.DataFeed.HttpRequest.Behaviour implementations

  Calls the client / mock depending on environment settings.

    ## Examples

      iex> add_address("123")
      {ok, "123"}

    ## Examples

      iex> add_address(123)
      {:error, "address must be a binary type"}
  """

  defdelegate add_address(address), to: HttpRequest

  @doc """
  Midterm.DataFeed.HttpRequest.Behaviour implementations

  Calls the client / mock depending on environment settings.

    ## Examples

      iex> remove_address("123")
      {ok, "123"}

    ## Examples

      iex> remove_address(123)
      {:error, "address must be a binary type"}
  """

  defdelegate remove_address(address), to: HttpRequest

  @doc """
  Returns the list of blocks.

  ## Examples

      iex> list_blocks()
      [%Block{}, ...]

  """
  def list_blocks do
    Repo.all(Block)
  end

  @doc """
  Gets a single block.

  Raises `Ecto.NoResultsError` if the Block does not exist.

  ## Examples

      iex> get_block!(123)
      %Block{}

      iex> get_block!(456)
      ** (Ecto.NoResultsError)

  """
  def get_block!(id), do: Repo.get!(Block, id)

  @doc """
  Creates a block.

  ## Examples

      iex> create_block(%{field: value})
      {:ok, %Block{}}

      iex> create_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_block(attrs \\ %{}) do
    %Block{}
    |> Block.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a block.

  ## Examples

      iex> update_block(block, %{field: new_value})
      {:ok, %Block{}}

      iex> update_block(block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_block(%Block{} = block, attrs) do
    block
    |> Block.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a block.

  ## Examples

      iex> delete_block(block)
      {:ok, %Block{}}

      iex> delete_block(block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_block(%Block{} = block) do
    Repo.delete(block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking block changes.

  ## Examples

      iex> change_block(block)
      %Ecto.Changeset{data: %Block{}}

  """
  def change_block(%Block{} = block, attrs \\ %{}) do
    Block.changeset(block, attrs)
  end
end

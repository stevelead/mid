defmodule Midterm.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :header_hash, :string
      add :slot, :integer
      add :rolled_back, :boolean, default: false, null: false
      add :received_block_id, :integer

      timestamps()
    end

    create unique_index(:blocks, [:slot])
    create unique_index(:blocks, [:header_hash])
  end
end

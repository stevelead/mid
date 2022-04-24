defmodule Midterm.Repo.Migrations.CreateNotificationTypes do
  use Ecto.Migration

  def change do
    create table(:notification_types) do
      add :type, :string

      timestamps()
    end
  end
end

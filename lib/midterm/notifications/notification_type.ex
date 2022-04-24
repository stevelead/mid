defmodule Midterm.Notifications.NotificationType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notification_types" do
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(notification_type, attrs) do
    notification_type
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end

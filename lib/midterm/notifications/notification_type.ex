defmodule Midterm.Notifications.NotificationType do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Notifications.Notification

  schema "notification_types" do
    field :type, :string

    has_one :notification_type, Notification

    timestamps()
  end

  @doc false
  def changeset(notification_type, attrs) do
    notification_type
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end

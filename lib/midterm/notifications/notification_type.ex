defmodule Midterm.Notifications.NotificationType do
  use Ecto.Schema
  import Ecto.Changeset

  alias Midterm.Notifications.Notification

  schema "notification_types" do
    field :type, :string

    has_one :notification_type, Notification

    timestamps()
  end

  @required_parameters [:type]

  @doc false
  def changeset(notification_type, attrs) do
    notification_type
    |> cast(attrs, @required_parameters)
    |> validate_required(@required_parameters)
  end
end

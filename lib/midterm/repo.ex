defmodule Midterm.Repo do
  use Ecto.Repo,
    otp_app: :midterm,
    adapter: Ecto.Adapters.Postgres
end

defmodule MidtermWeb.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias Midterm.Repo
  alias Midterm.Accounts.ApiAccess

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> api_key] <- get_req_header(conn, "authorization"),
         {:ok, api_access} <-
           get_api_key_account_address_hash(api_key),
         :ok <- check_key_is_active(api_access),
         :ok <- check_key_is_current(api_access) do
      %{current_api_access: api_access}
    else
      _ -> %{}
    end
  end

  defp get_api_key_account_address_hash(api_key) do
    ApiAccess
    |> where(api_key: ^api_key)
    |> Repo.one()
    |> Repo.preload([:account])
    |> case do
      nil -> {:error, "invalid authorization key"}
      api_access -> {:ok, api_access}
    end
  end

  defp check_key_is_active(%{status: status}) when status === :active, do: :ok
  defp check_key_is_active(_api_access), do: {:error, :api_access_not_active}

  defp check_key_is_current(%{valid_until: valid_until}) do
    now = DateTime.now!("Etc/UTC")

    case DateTime.diff(now, valid_until) do
      diff when diff < 0 -> :ok
      _ -> {:error, :api_access_not_current}
    end
  end
end

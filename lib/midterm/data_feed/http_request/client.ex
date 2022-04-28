defmodule Midterm.DataFeed.HttpRequest.Client do
  @behaviour Midterm.DataFeed.HttpRequest.Behaviour
  require Logger

  alias Finch.Response

  @impl true
  def add_address(address) when is_binary(address) do
    case add_address_request(address) do
      {:ok, %Response{body: "ok"}} ->
        {:ok, address}

      {:error, _error} ->
        Logger.warn("#{inspect(__MODULE__)} add_address error for address #{address}")
        {:error, "server error"}

      _res ->
        Logger.warn(
          "#{inspect(__MODULE__)} unhandled add_address response for address #{address}"
        )

        {:error, "server error"}
    end
  end

  @impl true
  def add_address(_address) do
    {:error, "address must be a binary type"}
  end

  @impl true
  def remove_address(address) when is_binary(address) do
    case remove_address_request(address) do
      {:ok, %Response{body: "ok"}} ->
        {:ok, address}

      {:error, _error} ->
        Logger.warn("#{inspect(__MODULE__)} remove_address error for address #{address}")
        {:error, "server error"}

      _res ->
        "#{inspect(__MODULE__)} unhandled remove_address response for address #{address}"
        {:error, "server error"}
    end
  end

  @impl true
  def remove_address(_address) do
    {:error, "address must be a binary type"}
  end

  defp add_address_request(address) do
    url = request_url() <> "add-address?address=#{address}"
    Finch.build(:post, url) |> Finch.request(MidtermFinch)
  end

  defp remove_address_request(address) do
    url = request_url() <> "remove-address?address=#{address}"
    Finch.build(:post, url) |> Finch.request(MidtermFinch)
  end

  defp request_url() do
    Application.get_env(:midterm, :http_request_client_url)
  end
end

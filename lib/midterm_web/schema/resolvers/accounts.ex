defmodule MidtermWeb.Resolvers.Accounts do
  alias Midterm.Accounts

  def get_account_by_address_hash(_parent, %{address_hash: address_hash}, %{context: context}) do
    case context do
      %{current_api_access: %{account: account}}
      when account.address_hash === address_hash ->
        Accounts.get_account_by_address_hash(address_hash)

      _ ->
        {:error, "unauthorized"}
    end
  end

  def create_watched_address(_parent, %{account_address_hash: account_address_hash} = params, %{
        context: context
      }) do
    case context do
      %{current_api_access: %{account: account}}
      when account.address_hash === account_address_hash ->
        Accounts.create_watched_address_and_account_watched_address(%{
          account_id: account.id,
          address_hash: params.watched_address_hash,
          name: params.name
        })

      _ ->
        {:error, "unauthorized"}
    end
  end

  def reset_api_key(_parent, %{account_address_hash: account_address_hash}, %{
        context: context
      }) do
    case context do
      %{current_api_access: %{account: account}}
      when account.address_hash === account_address_hash ->
        Accounts.update_api_key(account.id)

      _ ->
        {:error, "unauthorized"}
    end
  end

  def update_notification_preferences(
        _parent,
        %{account_address_hash: account_address_hash} = params,
        %{
          context: context
        }
      ) do
    case context do
      %{current_api_access: %{account: account}}
      when account.address_hash === account_address_hash ->
        case Accounts.find_notification_preference_by_account_id_and_watched_address_hash(
               account.id,
               params.watched_address_hash
             ) do
          {:ok, notification_preference} ->
            Accounts.update_notification_preference(
              notification_preference,
              params.notification_preferences
            )

          error ->
            error
        end

      _ ->
        {:error, "unauthorized"}
    end
  end
end

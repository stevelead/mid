defmodule Midterm.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Midterm.Repo

  alias Midterm.Accounts.Account
  alias EctoShorts.Actions

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  @doc """
  Gets a single account by the passed in address_hash.

  Returns an error tuple if the Account does not exist.

  ## Examples

      iex> get_account_by_address_hash(%{address_hash: "1"})
      {:ok, %Account{}}

      iex> get_account_by_address_hash(%{address_hash: "1"})
      {:error,
      %{
        code: :not_found,
        details: %{params: %{address_hash: "1"}, query: Midterm.Accounts.Account},
        message: "no records found"
      }}

  """
  def get_account_by_params(params),
    do: Actions.find(Account, params)

  @doc """
  Gets a single account by params passed

  Returns an error tuple if the Account does not exist.

  ## Examples

      iex> get_account(%{id: 1})
      {:ok, %Account{}}

      iex> get_account(%{id: 1})
      {:error,
      %{
        code: :not_found,
        details: %{params: %{id: 1}, query: Midterm.Accounts.Account},
        message: "no records found"
      }}

  """
  def get_account(params),
    do: Actions.find(Account, params)

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end

  alias Midterm.Accounts.WatchedAddress

  @doc """
  Returns the list of watched_addresses.

  ## Examples

      iex> list_watched_addresses()
      [%WatchedAddress{}, ...]

  """
  def list_watched_addresses do
    Repo.all(WatchedAddress)
  end

  @doc """
  Gets a single watched_address.

  Raises `Ecto.NoResultsError` if the Watched address does not exist.

  ## Examples

      iex> get_watched_address!(123)
      %WatchedAddress{}

      iex> get_watched_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_watched_address!(id), do: Repo.get!(WatchedAddress, id)

  @doc """
  Creates a watched_address.

  ## Examples

      iex> create_watched_address(%{field: value})
      {:ok, %WatchedAddress{}}

      iex> create_watched_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_watched_address(attrs \\ %{}) do
    %WatchedAddress{}
    |> WatchedAddress.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates or finds a watched_address.

  ## Examples

      iex> find_or_create_watched_address(%{field: value})
      {:ok, %AccountWatchedAddress{}}

      iex> find_or_create_watched_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def find_or_create_watched_address(attrs \\ %{}) do
    Actions.find_or_create(WatchedAddress, attrs)
  end

  @doc """
  Updates a watched_address.

  ## Examples

      iex> update_watched_address(watched_address, %{field: new_value})
      {:ok, %WatchedAddress{}}

      iex> update_watched_address(watched_address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_watched_address(%WatchedAddress{} = watched_address, attrs) do
    watched_address
    |> WatchedAddress.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a watched_address.

  ## Examples

      iex> delete_watched_address(watched_address)
      {:ok, %WatchedAddress{}}

      iex> delete_watched_address(watched_address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_watched_address(%WatchedAddress{} = watched_address) do
    Repo.delete(watched_address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking watched_address changes.

  ## Examples

      iex> change_watched_address(watched_address)
      %Ecto.Changeset{data: %WatchedAddress{}}

  """
  def change_watched_address(%WatchedAddress{} = watched_address, attrs \\ %{}) do
    WatchedAddress.changeset(watched_address, attrs)
  end

  alias Midterm.Accounts.AccountWatchedAddress

  @doc """
  Returns the list of account_watched_addresses.

  ## Examples

      iex> list_account_watched_addresses()
      [%AccountWatchedAddress{}, ...]

  """
  def list_account_watched_addresses do
    Repo.all(AccountWatchedAddress)
  end

  @doc """
  Gets a single account_watched_address.

  Raises `Ecto.NoResultsError` if the Account watched address does not exist.

  ## Examples

      iex> get_account_watched_address!(123)
      %AccountWatchedAddress{}

      iex> get_account_watched_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account_watched_address!(id), do: Repo.get!(AccountWatchedAddress, id)

  @doc """
  Creates a account_watched_address.

  ## Examples

      iex> create_account_watched_address(%{field: value})
      {:ok, %AccountWatchedAddress{}}

      iex> create_account_watched_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_account_watched_address(attrs \\ %{}) do
    %AccountWatchedAddress{}
    |> AccountWatchedAddress.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a watched_address and account_watched_address with the watched_address id.

  ## Examples

      iex> create_watched_address_and_account_watched_address(%{field: value})
      {:ok, %AccountWatchedAddress{}}

      iex> create_watched_address_and_account_watched_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_watched_address_and_account_watched_address(attrs) do
    with {:ok, watched_address} <- find_or_create_watched_address(attrs),
         attrs_with_watched_address_id = Map.put(attrs, :watched_address_id, watched_address.id),
         {:ok, _account_watched_address} <-
           create_account_watched_address(attrs_with_watched_address_id) do
      {:ok, watched_address}
    end
  end

  @doc """
  Updates a account_watched_address.

  ## Examples

      iex> update_account_watched_address(account_watched_address, %{field: new_value})
      {:ok, %AccountWatchedAddress{}}

      iex> update_account_watched_address(account_watched_address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_watched_address(%AccountWatchedAddress{} = account_watched_address, attrs) do
    account_watched_address
    |> AccountWatchedAddress.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account_watched_address.

  ## Examples

      iex> delete_account_watched_address(account_watched_address)
      {:ok, %AccountWatchedAddress{}}

      iex> delete_account_watched_address(account_watched_address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account_watched_address(%AccountWatchedAddress{} = account_watched_address) do
    Repo.delete(account_watched_address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account_watched_address changes.

  ## Examples

      iex> change_account_watched_address(account_watched_address)
      %Ecto.Changeset{data: %AccountWatchedAddress{}}

  """
  def change_account_watched_address(
        %AccountWatchedAddress{} = account_watched_address,
        attrs \\ %{}
      ) do
    AccountWatchedAddress.changeset(account_watched_address, attrs)
  end

  alias Midterm.Accounts.NotificationPreference

  @doc """
  Returns the list of notification_preferences.

  ## Examples

      iex> list_notification_preferences()
      [%NotificationPreference{}, ...]

  """
  def list_notification_preferences do
    Repo.all(NotificationPreference)
  end

  @doc """
  Gets a single notification_preference.

  Raises `Ecto.NoResultsError` if the Notification preference does not exist.

  ## Examples

      iex> get_notification_preference!(123)
      %NotificationPreference{}

      iex> get_notification_preference!(456)
      ** (Ecto.NoResultsError)

  """
  def get_notification_preference!(id), do: Repo.get!(NotificationPreference, id)

  @doc """
  Finds a single notification_preference by passed in params.

  Raises `Ecto.NoResultsError` if the Notification preference does not exist.

  ## Examples

      iex> get_notification_preference!(123)
      %NotificationPreference{}

      iex> get_notification_preference!(456)
      ** (Ecto.NoResultsError)

  """
  def find_notification_preference(params), do: Actions.find(NotificationPreference, params)

  @doc """
  Finds a single notification_preference by passed in params.

  Raises `Ecto.NoResultsError` if the Notification preference does not exist.

  ## Examples

      iex> get_notification_preference!(123)
      %NotificationPreference{}

      iex> get_notification_preference!(456)
      ** (Ecto.NoResultsError)

  """
  def find_notification_preference_by_account_id_and_watched_address_hash(
        account_id,
        watched_address_hash
      ) do
    with {:ok, watched_address} <-
           Actions.find(WatchedAddress, address_hash: watched_address_hash) do
      Actions.find(NotificationPreference, %{
        account_id: account_id,
        watched_address_id: watched_address.id
      })
    end
  end

  @doc """
  Creates a notification_preference.

  ## Examples

      iex> create_notification_preference(%{field: value})
      {:ok, %NotificationPreference{}}

      iex> create_notification_preference(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_notification_preference(attrs \\ %{}) do
    %NotificationPreference{}
    |> NotificationPreference.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a notification_preference.

  ## Examples

      iex> update_notification_preference(notification_preference, %{field: new_value})
      {:ok, %NotificationPreference{}}

      iex> update_notification_preference(notification_preference, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_notification_preference(%NotificationPreference{} = notification_preference, attrs) do
    notification_preference
    |> NotificationPreference.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a notification_preference.

  ## Examples

      iex> delete_notification_preference(notification_preference)
      {:ok, %NotificationPreference{}}

      iex> delete_notification_preference(notification_preference)
      {:error, %Ecto.Changeset{}}

  """
  def delete_notification_preference(%NotificationPreference{} = notification_preference) do
    Repo.delete(notification_preference)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking notification_preference changes.

  ## Examples

      iex> change_notification_preference(notification_preference)
      %Ecto.Changeset{data: %NotificationPreference{}}

  """
  def change_notification_preference(
        %NotificationPreference{} = notification_preference,
        attrs \\ %{}
      ) do
    NotificationPreference.changeset(notification_preference, attrs)
  end

  alias Midterm.Accounts.CreditPurchase

  @doc """
  Returns the list of credit_purchases.

  ## Examples

      iex> list_credit_purchases()
      [%CreditPurchase{}, ...]

  """
  def list_credit_purchases do
    Repo.all(CreditPurchase)
  end

  @doc """
  Gets a single credit_purchase.

  Raises `Ecto.NoResultsError` if the Credit purchase does not exist.

  ## Examples

      iex> get_credit_purchase!(123)
      %CreditPurchase{}

      iex> get_credit_purchase!(456)
      ** (Ecto.NoResultsError)

  """
  def get_credit_purchase!(id), do: Repo.get!(CreditPurchase, id)

  @doc """
  Creates a credit_purchase.

  ## Examples

      iex> create_credit_purchase(%{field: value})
      {:ok, %CreditPurchase{}}

      iex> create_credit_purchase(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_credit_purchase(attrs \\ %{}) do
    %CreditPurchase{}
    |> CreditPurchase.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a credit_purchase.

  ## Examples

      iex> update_credit_purchase(credit_purchase, %{field: new_value})
      {:ok, %CreditPurchase{}}

      iex> update_credit_purchase(credit_purchase, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_credit_purchase(%CreditPurchase{} = credit_purchase, attrs) do
    credit_purchase
    |> CreditPurchase.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a credit_purchase.

  ## Examples

      iex> delete_credit_purchase(credit_purchase)
      {:ok, %CreditPurchase{}}

      iex> delete_credit_purchase(credit_purchase)
      {:error, %Ecto.Changeset{}}

  """
  def delete_credit_purchase(%CreditPurchase{} = credit_purchase) do
    Repo.delete(credit_purchase)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking credit_purchase changes.

  ## Examples

      iex> change_credit_purchase(credit_purchase)
      %Ecto.Changeset{data: %CreditPurchase{}}

  """
  def change_credit_purchase(%CreditPurchase{} = credit_purchase, attrs \\ %{}) do
    CreditPurchase.changeset(credit_purchase, attrs)
  end

  alias Midterm.Accounts.ApiAccess

  @doc """
  Returns the list of api_access.

  ## Examples

      iex> list_api_access()
      [%ApiAccess{}, ...]

  """
  def list_api_access do
    Repo.all(ApiAccess)
  end

  @doc """
  Gets a single api_access.

  Raises `Ecto.NoResultsError` if the Api access does not exist.

  ## Examples

      iex> get_api_access!(123)
      %ApiAccess{}

      iex> get_api_access!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api_access!(id), do: Repo.get!(ApiAccess, id)

  @doc """
  Creates a api_access.

  ## Examples

      iex> create_api_access(%{field: value})
      {:ok, %ApiAccess{}}

      iex> create_api_access(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api_access(attrs \\ %{}) do
    %ApiAccess{}
    |> ApiAccess.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a api_access.

  ## Examples

      iex> update_api_access(api_access, %{field: new_value})
      {:ok, %ApiAccess{}}

      iex> update_api_access(api_access, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api_access(%ApiAccess{} = api_access, attrs) do
    api_access
    |> ApiAccess.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a api_key in an api_access with account_id.

  ## Examples

      iex> update_api_key("1")
      {:ok, %ApiAccess{}}

      iex> update_api_key("bad_account_id")
      {:error, %Ecto.Changeset{}}

  """
  def update_api_key(account_id) do
    new_api_key = Ecto.UUID.generate()
    attrs = %{account_id: account_id, api_key: new_api_key}

    case Actions.find(ApiAccess, %{account_id: account_id}) do
      {:ok, api_access} ->
        api_access
        |> ApiAccess.changeset(attrs)
        |> Repo.update()

      error ->
        error
    end
  end

  @doc """
  Deletes a api_access.

  ## Examples

      iex> delete_api_access(api_access)
      {:ok, %ApiAccess{}}

      iex> delete_api_access(api_access)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api_access(%ApiAccess{} = api_access) do
    Repo.delete(api_access)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking api_access changes.

  ## Examples

      iex> change_api_access(api_access)
      %Ecto.Changeset{data: %ApiAccess{}}

  """
  def change_api_access(%ApiAccess{} = api_access, attrs \\ %{}) do
    ApiAccess.changeset(api_access, attrs)
  end
end

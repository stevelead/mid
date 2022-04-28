defmodule Midterm.DataFeed.BlockProcessor do
  require Logger

  alias MidtermWeb.Endpoint
  alias Midterm.Accounts
  alias Midterm.DataFeed.BlockProcessorHelpers

  def process_block(block) do
    with {:ok, atomised_block} <- transform_string_keys(block),
         process_responses <- dispatch_notifications(block),
         :ok <- check_all_responses_ok(process_responses),
         {:ok, block} <- save_block_data(atomised_block) do
      {:ok, block}
    else
      _ ->
        Logger.warn("error processing block with id #{block["id"]}...")
        {:ok, block}
    end
  end

  def dispatch_notifications(block) do
    for transaction_address_detail <- block.transaction_address_details,
        account_address <- get_accounts_watching_address(transaction_address_detail),
        BlockProcessorHelpers.send_notifications?(
          account_address,
          transaction_address_detail
        ) do
      Logger.info("processed block with id #{block["id"]}...")
      dispatch_notification(transaction_address_detail, account_address)
    end
  end

  def transform_string_keys(item) when is_map(item) do
    for {key, value} <- item do
      transform({key, value})
    end
    |> Enum.filter(fn
      {key, _value} -> is_atom(key)
      _ -> false
    end)
    |> Enum.into(%{})
  end

  def transform_string_keys(item) when is_list(item) do
    Enum.map(item, &transform_string_keys/1)
  end

  defp transform({"id", value}), do: {:id, value}
  defp transform({"header_hash", value}), do: {:header_hash, value}
  defp transform({"slot", value}), do: {:slot, value}

  defp transform({"transaction_address_details", value}),
    do: {:transaction_address_details, transform_string_keys(value)}

  defp transform({"inputs_agg_assets", value}), do: {:inputs_agg_assets, value}
  defp transform({"inputs_agg_value", value}), do: {:inputs_agg_value, value}
  defp transform({"outputs_agg_assets", value}), do: {:outputs_agg_assets, value}
  defp transform({"outputs_agg_value", value}), do: {:outputs_agg_value, value}
  defp transform({"tx_utxo_balance", value}), do: {:tx_utxo_balance, value}

  defp transform({"transaction_id", value}), do: {:transaction_id, value}
  defp transform({"transaction", value}), do: {:transaction, transform_string_keys(value)}
  defp transform({"tx_id", value}), do: {:tx_id, value}

  defp transform({"address_id", value}), do: {:address_id, value}
  defp transform({"address", value}), do: {:address, transform_string_keys(value)}
  defp transform({"address_hash", value}), do: {:address_hash, value}

  defp transform({key, value}) do
    Logger.warn("#{__MODULE__} transform/1 received unexpected key value pair {#{key}, #{value}}")
  end

  defp get_accounts_watching_address(%{address: %{address_hash: address_hash}}) do
    with {:ok, watched_address} <- Accounts.get_watched_address(%{address_hash: address_hash}) do
      Accounts.list_account_watched_addresses()
      |> Enum.filter(&(&1.watched_address_id == watched_address.id))
    end
  end

  defp dispatch_notification(notification_details, account_address) do
    account_id = Integer.to_string(account_address.account.id)
    Logger.info("broadcasting notification info for account id #{account_id}")

    Endpoint.broadcast!("notifications", "new_notification:#{account_id}", %{
      notification_details: notification_details,
      account_address: account_address
    })
  end

  def check_all_responses_ok(responses) do
    Enum.all?(responses, fn item -> item === :ok end)
  end

  def save_block_data(block) do
    block
    |> Map.put(:received_block_id, block.id)
  end
end

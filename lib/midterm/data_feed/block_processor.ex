defmodule Midterm.DataFeed.BlockProcessor do
  require Logger

  alias MidtermWeb.Endpoint
  alias Midterm.Accounts
  alias Midterm.DataFeed.BlockProcessorHelpers

  def process_block(block) do
    Logger.info("processing block with id #{block["id"]}...")

    for notification_details <- block.transaction_address_details,
        account_address <- accounts_watching_address(notification_details),
        BlockProcessorHelpers.send_notifications?(account_address, notification_details) do
      dispatch_notification(notification_details, account_address)
    end
  end

  defp accounts_watching_address(%{address: %{address_hash: address_hash}}) do
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
end

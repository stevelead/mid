defmodule Midterm.BlocksProcessorTest do
  use Midterm.DataCase, async: true
  import ExUnit.CaptureLog

  alias MidtermWeb.Endpoint
  import Midterm.AccountsFixtures
  import Midterm.BlockFixtures

  describe "block processor" do
    test "dispatches a notification when preferences are satisfies" do
      test_address = List.first(address_list())
      account = account_fixture(%{credits: 100})
      Endpoint.subscribe("notifications")

      watched_address = watched_address_fixture(%{address_hash: test_address})

      account_watched_address =
        account_watched_address_fixture(%{
          account: account,
          watched_address: watched_address
        })

      notification_preference =
        notification_preference_fixture(%{
          account_watched_address: account_watched_address,
          devices_to_notify: ["browser", "email"],
          limit_by_type: :received,
          values_greater_than: 50
        })

      block = saved_block_fixture()

      assert [:ok] == Midterm.DataFeed.BlockProcessor.dispatch_notifications(block)

      assert_received %Phoenix.Socket.Broadcast{
        event: event,
        payload: payload
      }

      assert ^event = "new_notification:#{account.id}"

      expected_notification_details =
        block.transaction_address_details
        |> List.first()
        |> Map.drop([:account, :notification_preference])

      expected_account_watched_address =
        account_watched_address
        |> Map.put(:account, account)
        |> Map.put(:notification_preference, notification_preference)

      assert payload == %{
               account_address: expected_account_watched_address,
               notification_details: expected_notification_details
             }
    end

    test "logs an error if process errors" do
      incomplete_block = %{id: "1"}

      log =
        capture_log(fn ->
          assert [:ok] != Midterm.DataFeed.BlockProcessor.process_block(incomplete_block)
        end)

      assert log =~ "error"
      assert log =~ incomplete_block.id
    end
  end
end

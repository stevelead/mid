defmodule Midterm.BlocksProcessorHelpersTest do
  use Midterm.DataCase, async: true

  alias Midterm.DataFeed.BlockProcessorHelpers
  import Midterm.AccountsFixtures
  import Midterm.BlockFixtures

  describe "send_notifications/2" do
    test "returns true when preferences are satisfied" do
      account = account_fixture(%{credits: 100})

      preferences =
        notification_preference_fixture(%{limit_by_type: :received, values_greater_than: 50})

      transaction_address_details =
        transaction_address_details_fixture(%{
          outputs_agg_value: 100,
          inputs_agg_value: 0
        })

      assert true ==
               BlockProcessorHelpers.send_notifications?(
                 %{account: account, notification_preference: preferences},
                 transaction_address_details
               )

      preferences =
        notification_preference_fixture(%{limit_by_type: :spent, values_greater_than: 50})

      transaction_address_details =
        transaction_address_details_fixture(%{
          outputs_agg_value: 0,
          inputs_agg_value: 100
        })

      assert true ==
               BlockProcessorHelpers.send_notifications?(
                 %{account: account, notification_preference: preferences},
                 transaction_address_details
               )
    end

    test "returns false when notification preferences are not satisfied" do
      account = account_fixture(%{credits: 100})
      preferences = notification_preference_fixture(%{limit_by_type: :received})

      transaction_address_details =
        transaction_address_details_fixture(%{outputs_agg_value: 0, inputs_agg_value: 10})

      assert false ==
               BlockProcessorHelpers.send_notifications?(
                 %{account: account, notification_preference: preferences},
                 transaction_address_details
               )

      preferences =
        notification_preference_fixture(%{limit_by_type: :spent, values_greater_than: 50})

      transaction_address_details =
        transaction_address_details_fixture(%{outputs_agg_value: 0, inputs_agg_value: 10})

      assert false ==
               BlockProcessorHelpers.send_notifications?(
                 %{account: account, notification_preference: preferences},
                 transaction_address_details
               )
    end

    test "returns false when there are no devices to notify" do
      transaction_address_details = transaction_address_details_fixture()

      scenarios = [nil, %{devices_to_notify: nil}, %{devices_to_notify: []}]

      for preferences <- scenarios do
        assert false ==
                 BlockProcessorHelpers.send_notifications?(
                   %{notification_preference: preferences},
                   transaction_address_details
                 )
      end
    end

    test "returns false when an account has insufficient credits" do
      account = account_fixture(%{credits: nil})
      preferences = notification_preference_fixture()
      transaction_address_details = transaction_address_details_fixture()

      assert false ==
               BlockProcessorHelpers.send_notifications?(
                 %{account: account, notification_preference: preferences},
                 transaction_address_details
               )

      account = account_fixture(%{credits: 1})
      preferences = notification_preference_fixture(devices_to_notify: ["browser", "sms"])

      assert false ==
               BlockProcessorHelpers.send_notifications?(
                 %{account: account, notification_preference: preferences},
                 transaction_address_details
               )
    end
  end
end

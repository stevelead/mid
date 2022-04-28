defmodule Midterm.DataFeed.BlockProcessorHelpers do
  def send_notifications?(%{notification_preference: nil}, _), do: false
  def send_notifications?(%{notification_preference: %{devices_to_notify: nil}}, _), do: false
  def send_notifications?(%{notification_preference: %{devices_to_notify: []}}, _), do: false

  def send_notifications?(account_address, notification_details) do
    if account_has_sufficient_credit?(account_address) do
      passes_notification_preferences?(
        account_address.notification_preference,
        notification_details
      )
    else
      false
    end
  end

  defp account_has_sufficient_credit?(%{
         notification_preference: notification_preference,
         account: account
       }) do
    get_chosen_devices(notification_preference)
    |> check_if_sufficient_credit(account)
  end

  defp get_chosen_devices(nil = _notification_preference), do: []

  defp get_chosen_devices(%{devices_to_notify: nil}), do: []
  defp get_chosen_devices(%{devices_to_notify: []}), do: []
  defp get_chosen_devices(%{devices_to_notify: devices}) when is_list(devices), do: devices

  defp check_if_sufficient_credit(_, %{credits: nil}), do: false
  defp check_if_sufficient_credit(_, %{credits: credits}) when credits <= 0, do: false

  defp check_if_sufficient_credit(chosen_devices, %{credits: credits}) do
    length(chosen_devices) <= credits
  end

  defp passes_notification_preferences?(notification_preference, notification_details) do
    get_preferences_to_check(notification_preference)
    |> Enum.all?(&evaluate_preference(&1, notification_details))
  end

  defp get_preferences_to_check(notification_preference) do
    preferences_to_check = [:limit_by_type, :values_greater_than]
    Map.take(notification_preference, preferences_to_check)
  end

  defp evaluate_preference({:limit_by_type, nil}, _), do: true
  defp evaluate_preference({:limit_by_type, :all}, _), do: true

  defp evaluate_preference({:limit_by_type, :received}, %{tx_utxo_balance: tx_utxo_balance}) do
    if tx_utxo_balance < 0, do: true, else: false
  end

  defp evaluate_preference({:limit_by_type, :spent}, %{tx_utxo_balance: tx_utxo_balance}) do
    if tx_utxo_balance > 0, do: true, else: false
  end

  defp evaluate_preference({:values_greater_than, nil}, _), do: true

  defp evaluate_preference({:values_greater_than, value}, %{tx_utxo_balance: balance}) do
    balance > value || balance < -value
  end
end

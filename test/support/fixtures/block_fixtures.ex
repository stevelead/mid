defmodule Midterm.BlockFixtures do
  def saved_block_fixture() do
    transactions = generate_transactions()

    transaction_address_details =
      Enum.flat_map(
        transactions,
        &Enum.map(&1.transaction_address_details, fn tad ->
          Map.put(tad, :transaction, Map.drop(&1, [:transaction_address_details]))
        end)
      )

    %{
      id: 1,
      header_hash: generate_hash(),
      slot: generate_slot(),
      transaction_address_details: transaction_address_details
    }
  end

  def transaction_address_details_fixture(defaults \\ %{}) do
    address = defaults[:address] || nil
    inputs_agg_value = defaults[:inputs_agg_value] || generate_value(1000)
    outputs_agg_value = defaults[:outputs_agg_value] || generate_value(1000)

    tx_utxo_balance = inputs_agg_value - outputs_agg_value

    %{
      id: generate_id(),
      inputs_agg_assets: %{},
      inputs_agg_value: inputs_agg_value,
      outputs_agg_assets: %{},
      outputs_agg_value: outputs_agg_value,
      tx_utxo_balance: tx_utxo_balance,
      transaction_id: generate_id(),
      address_id: generate_id(),
      address: address
    }
  end

  def address_list() do
    [
      "addr1qxw2cfwdquramm7cvuwp6tx4wvfmvdzy7wveah7xgjtdp2uqcl2dl3xlpgkw5jmpvgscp7dyx88vzusphea7fgneenmqfldqvp"
    ]
  end

  defp generate_transactions() do
    address = Enum.at(generate_addresses(), 0)
    defaults = %{address: address, outputs_agg_value: 100, inputs_agg_value: 0}

    [
      %{
        tx_id: generate_hash(),
        transaction_address_details: [transaction_address_details_fixture(defaults)]
      }
    ]
  end

  defp generate_addresses() do
    for {addr_hash, ind} <- Enum.with_index(address_list()) do
      %{id: ind, address_hash: addr_hash}
    end
  end

  defp generate_id() do
    Enum.at(StreamData.integer(10..1000), 1)
  end

  defp generate_value(n) do
    Enum.at(StreamData.integer(1..n), 1)
  end

  defp generate_hash() do
    Enum.take(StreamData.byte(), 20) |> Enum.join() |> Base.encode16(case: :lower)
  end

  defp generate_slot() do
    Enum.at(StreamData.integer(1000..10000), 0)
  end
end

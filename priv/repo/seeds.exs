# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Midterm.Repo.insert!(%Midterm.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, account} = Midterm.Accounts.create_account(%{address_hash: "123", credits: 100})

addressses =
  Enum.map(addresses(), &Midterm.Accounts.create_watched_address(%{address_hash: &1}))
  |> Enum.map(fn {:ok, address} -> address end)

account_addresses =
  Enum.map(
    addressses,
    &Midterm.Accounts.create_account_watched_address(%{
      account_id: 1,
      watched_address_id: &1.id
    })
  )

_notification_preference =
  Enum.map(
    account_addresses,
    &Midterm.Accounts.create_notification_preference(%{
      account_watched_address_id: &1.id
    })
  )

def addresses() do
  [
    "addr1qxw2cfwdquramm7cvuwp6tx4wvfmvdzy7wveah7xgjtdp2uqcl2dl3xlpgkw5jmpvgscp7dyx88vzusphea7fgneenmqfldqvp",
    "addr1vy3qpx09uscywhppj5vp08hu0ekg9zwmq2ysfq6qyh2mpps865j6t",
    "addr1vyjdya9lmyfmysdgej3qc6thwat33lwm3umk8uwnvhy9g3gzvd2jp",
    "addr1q9q6p8lc40k9lw82rd5pezpnvj32855nfzuuhw2zjmwnq37906jsa6f6m2a",
    "addr1q9gytxhj83j6ahles2hytxv5vc9nz2nj9tnlp24t887jupxmhdlqtdnpfl7u8ptjfvygy0hvs49yczr9lzrlys280pmshuec9m",
    "addr1q83luynzex42a4hc4u85sws7ny3m8hupdrs90s223ktznak2k32zhylhsr90w07ymv5nu97eaz6j7m9kyyvqf500536sgsusef"
  ]
end

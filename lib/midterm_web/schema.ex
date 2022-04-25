defmodule MidtermWeb.Schema do
  use Absinthe.Schema

  import_types MidtermWeb.Types.CustomJSON
  import_types MidtermWeb.Types.CustomDatetime
  import_types MidtermWeb.Types.Accounts
  import_types MidtermWeb.Types.DataFeed
  import_types MidtermWeb.Types.Notifications

  import_types MidtermWeb.Queries.Accounts

  query do
    import_fields :accounts_queries
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(MidtermWeb.Repo)

    dataloader =
      Dataloader.new()
      |> Dataloader.add_source(MidtermWebRepo, source)

    Map.put(ctx, :loader, dataloader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end

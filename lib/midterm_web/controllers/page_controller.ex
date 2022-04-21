defmodule MidtermWeb.PageController do
  use MidtermWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule SimpleChat.PageController do
  use SimpleChat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

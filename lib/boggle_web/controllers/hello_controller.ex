defmodule BoggleWeb.HelloController do
  use BoggleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule BoggleWeb.HelloController do
  use BoggleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def greet(conn, %{"messenger" => messenger}) do
    render(conn, "greet.html", messenger: messenger)
  end
end

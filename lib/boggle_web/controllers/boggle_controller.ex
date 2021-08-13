defmodule BoggleWeb.BoggleController do
  use BoggleWeb, :controller

  def index(conn, _params) do
    render(conn, "boggle.html")
  end

  #defp boggle_board() do
  #  Enum.random(?A..?Z)
  #end

  #defp boggle_letter(num) do
  #end

  #defp boggle_letter(51) do
  #end

end

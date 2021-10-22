defmodule BoggleWeb.BoggleController do
  use BoggleWeb, :controller
  alias Boggle.BoggleBoard

  def index(conn, _params) do
    board_size = 4
    boggle_str = BoggleBoard.new_board(board_size)
    render(conn, "boggle.html", boggle_str: boggle_str, board_size: board_size)
  end
end

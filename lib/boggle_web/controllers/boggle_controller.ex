defmodule BoggleWeb.BoggleController do
  use BoggleWeb, :controller
  alias Boggle.{BoggleBoard, Lexicon}

  @lexicon Lexicon.get_lexicon("assets/static/bogwords_short.txt")

  def index(conn, _params) do
    board_size = 5
    boggle_str = BoggleBoard.new_board(board_size)
    IO.inspect(@lexicon)
    render(conn, "boggle.html", boggle_str: boggle_str, board_size: board_size)
  end

  def word_on_board(conn, %{"word" => word}) do
    json(conn, %{is_word: Lexicon.is_word?(@lexicon, word)})
  end

end

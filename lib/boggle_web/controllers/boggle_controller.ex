defmodule BoggleWeb.BoggleController do
  use BoggleWeb, :controller

  def index(conn, _params) do
    board_size = 4
    boggle_dice = boggle_dice(board_size)
    IO.puts("Boggle Die 1: #{Enum.at(boggle_dice, 1)}")
    boggle_str = boggle_letter(board_size*board_size, [], boggle_dice)
    render(conn, "boggle.html", boggle_str: boggle_str, board_size: board_size)
  end

  defp boggle_letter(die_idx, boggle_str, dice) when die_idx > 0 do
    letter = String.at(Enum.at(dice, die_idx-1), Enum.random(0..5))
    letter = case letter do
      "Q" -> "Qu"
      _ -> letter
    end
    boggle_str = [ letter | boggle_str ]
    IO.puts("Boggle Letter: #{letter}, Boggle String: #{boggle_str}, Boggle Index: #{die_idx}")
    boggle_letter(die_idx-1, boggle_str, dice)
  end

  defp boggle_letter(0, boggle_str, _dice) do
    boggle_str
  end

  defp boggle_dice(board_size) do
    case board_size do
      4 -> Enum.shuffle([ "AAEEGN", "ABBJOO", "ACHOPS", "AFFKPS",
             "AOOTTW", "CIMOTU", "DEILRX", "DELRVY",
             "DISTTY", "EEGHNW", "EEINSU", "EHRTVW",
             "EIOSST", "ELRTTY", "HIMNQU", "HLNNRZ" ])
      5 -> Enum.shuffle([ "AAFIRS", "ADENNN", "AAAFRS", "AEEGMU", "AAEEEE",
             "AEEEEM", "AFIRSY", "AEGMNN", "BJKQXZ", "CEIPST",
             "CEIILT", "CCNSTW", "CEILPT", "DDLONR", "DHLNOR",
             "DHHLOR", "DHHNOT", "ENSSSU", "EMOTTT", "EIIITT",
             "FIPRSY", "GORRVW", "HIPRRY", "NOOTUW", "OOOTTU" ])
    end
  end

end

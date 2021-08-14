defmodule Boggle.BoggleBoard do

  def new_board(board_size) do
    boggle_letter(board_size*board_size, [], boggle_dice(board_size))
  end

  def word_on_board?(word, boggle_str) do
    board_size = get_board_size(boggle_str)
    Enum.any?(0..(board_size-1), fn row ->
      Enum.any?(0..(board_size-1), fn col ->
        boggle_helper(word, board_size, boggle_str, [], "", row, col, 0)
      end )
    end )
  end

  defp boggle_helper(word, board_size, boggle_str, used_cells, current_str, row, col, idx) when idx <= board_size*board_size do
    delta = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]
    cur_cell = row*board_size+col
    !(idx >= String.length(word)) # not at end of word
      && !(row < 0 || col < 0 || row >= board_size || col >= board_size || idx == board_size*board_size) # and not invalid index
      && !(Enum.member?(used_cells, cur_cell)) # and not reused cell
      && ((String.at(word, idx) |> String.upcase()) == String.at(boggle_str, cur_cell)) # and current character matches
      && Enum.any?(delta, fn {x, y} -> # test next cell
        boggle_helper(word, board_size, boggle_str,
          [cur_cell | used_cells],
          current_str <> String.at(boggle_str, cur_cell),
          row+x, col+y, idx+1)
        end)
      || idx >= String.length(word) # or return success
  end


  defp boggle_letter(die_idx, boggle_str, dice) when die_idx > 0 do
    letter = String.at(Enum.at(dice, die_idx-1), Enum.random(0..5))
    letter = case letter do
      "Q" -> "Qu"
      _ -> letter
    end
    boggle_str = [ letter | boggle_str ]
    boggle_letter(die_idx-1, boggle_str, dice)
  end

  defp boggle_letter(0, boggle_str, _dice) do
    boggle_str
  end

  defp boggle_dice(board_size) do
    case board_size do
      2 -> Enum.shuffle([ "AAEEGN", "ABBJOO",
                          "AOOTTW", "CIMOTU" ])
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

  defp get_board_size(boggle_str) do
    trunc(:math.sqrt(String.length(boggle_str)))
  end
end

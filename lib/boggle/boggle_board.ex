defmodule Boggle.BoggleBoard do
  def new_board(board_size) do
    boggle_letter(board_size*board_size, [], boggle_dice(board_size))
  end

  def word_on_board?(word, boggle_str) do
    boggle_board = String.graphemes(boggle_str)
      |> Enum.map(fn a -> %{:letter => a, :used => :false} end )

    board_size = get_board_size(boggle_str)
    Enum.each(0..(board_size-1), fn row ->
      Enum.each(0..(board_size-1), fn col ->
        boggle_helper(word, board_size, boggle_board, "", row, col, 0)
      end )
    end )
  end

  defp boggle_helper(word, board_size, boggle_board, current_str, row, col, idx) when idx <= board_size*board_size do
    delta = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]
    IO.puts("current run - row: #{row}, col: #{col}, idx: #{idx} &
      coord invalid: #{row < 0 || col < 0 || row >= board_size || col >= board_size} & idx invalid: #{idx == board_size*board_size} & end of word: #{idx >= String.length(word)} &
      cell used: #{Enum.at(boggle_board, row*board_size+col) |> Map.fetch!(:used)}")
    !(row < 0 || col < 0 || row >= board_size || col >= board_size || idx == board_size*board_size) # not invalid
      && !(idx >= String.length(word)) # and not at end of word
      && !(Enum.at(boggle_board, row*board_size+col) |> Map.fetch!(:used)) && boggle_board = Enum.map(boggle_board, 
      && Enum.map(delta, fn {x, y} ->
        boggle_helper(word, board_size, boggle_board, current_str, row+x, col+y, idx+1) end)
    #IO.puts("cell used: #{Enum.at(boggle_board, row*board_size+col) |> Map.fetch(:used)}")
    #IO.puts("end of word: #{idx >= String.length(word)}")
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

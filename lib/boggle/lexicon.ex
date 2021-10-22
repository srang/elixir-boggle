defmodule Boggle.Lexicon do

  def get_lexicon(file \\ "assets/static/bogwords.txt") do
    File.stream!(file)
            |> Stream.map(&String.strip/1)
            |> Enum.to_list()
  end

  def word_status(lexicon, word) do
    Enum.member?(lexicon, word)
  end
end

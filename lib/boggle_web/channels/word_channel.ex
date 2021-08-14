defmodule BoggleWeb.WordChannel do
  use BoggleWeb, :channel
  alias Boggle.{BoggleBoard, Lexicon}
  @lexicon Lexicon.get_lexicon()

  @impl true
  def join("game:default", payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("word", %{"word" => word, "boggle_str" => boggle_str}, socket) do
    broadcast(socket, "word", %{"word": word, "onBoard": word_on_board?(word, boggle_str)})
    {:noreply, socket}
  end

  @impl true
  def handle_info(:after_join, socket) do
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

  defp word_on_board?(word, boggle_str) do
    BoggleBoard.word_on_board?(word, boggle_str)
      && Lexicon.word_status(@lexicon, word)
  end

end

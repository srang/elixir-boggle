defmodule BoggleWeb.WordChannel do
  use BoggleWeb, :channel
  alias Boggle.{BoggleBoard, Lexicon}
  @lexicon Lexicon.get_lexicon("assets/static/bogwords_short.txt")

  @impl true
  def join("game:default", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("word", %{"word" => word}, socket) do
    broadcast(socket, "word", %{"word": word, "onBoard": word_on_board?(word)})
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  @impl true
  def handle_info(:after_join, socket) do
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

  defp word_on_board?(word) do
    is_word = Lexicon.is_word?(@lexicon, word)
  end

end

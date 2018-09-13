defmodule SimpleChat.UserSocket do
  use Phoenix.Socket

  channel "room:*", SimpleChat.RoomChannel

  transport :websocket, Phoenix.Transports.WebSocket

  # called whenever a new js client connects
  # this is where you want auth logic
  def connect(_params, socket) do
    {:ok, socket}
  end
  
  # this can help find all the active sockets that belong to a User
  # for the purpose of disconnecting for example
  def id(_socket), do: nil
end

defmodule SimpleChat.UserSocket do
  use Phoenix.Socket

  channel "room:*", SimpleChat.RoomChannel

  transport :websocket, Phoenix.Transports.WebSocket

  # called whenever a new js client connects
  # this is where you want auth logic
  def connect(%{"token" => token}, socket) do
    # max age is one day
    case Phoenix.Token.verify(socket, System.get_env("SOCKET_SECRET"), token, max_age: 86400) do
      {:ok, user_id} -> {:ok, assign(socket, :user_id, user_id)}
      {:error, _error} -> :error
    end
  end
  
  # this can help find all the active sockets that belong to a User
  # for the purpose of disconnecting for example
  def id(_socket), do: nil
end

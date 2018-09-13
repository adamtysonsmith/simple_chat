# https://hexdocs.pm/phoenix/Phoenix.Channel.html
defmodule SimpleChat.RoomChannel do
  use SimpleChat.Web, :channel
  alias SimpleChat.{Message, Room}

  # called when user joins channel
  def join("room:" <> room_id, _auth_msg, socket) do
    room_id = String.to_integer(room_id)

    room = Room
      |> Repo.get(room_id)
      |> Repo.preload(:messages)

    {:ok, %{messages: room.messages}, assign(socket, :room, room)}
  end
  
  # handles incoming events published by client
  def handle_in(event, data, socket) do
    room = socket.assigns.room
    %{"content" => content} = data
    
    changeset = room
      |> build_assoc(:messages)
      |> Message.changeset(%{content: content})
    
    case Repo.insert(changeset) do
      {:ok, message} ->
        broadcast!(socket, "room:#{socket.assigns.room.id}:new", message)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
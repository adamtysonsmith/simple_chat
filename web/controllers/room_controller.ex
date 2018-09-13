defmodule SimpleChat.RoomController do
  use SimpleChat.Web, :controller
  alias SimpleChat.Room

  plug SimpleChat.Plugs.RequireAuth when action not in [:index]
  
  def index(conn, _params) do
    IO.inspect conn.assigns
    rooms = Repo.all(Room)
    render conn, "rooms.html", rooms: rooms
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{}, %{})
    render conn, "new_room.html", [changeset: changeset]
  end
  
  # form data is available in params
  def create(conn, %{"room" => room}) do
    changeset = conn.assigns.user
      |> build_assoc(:rooms)
      |> Room.changeset(room)
    
    case Repo.insert(changeset) do
      {:ok, post} -> conn 
        |> put_flash(:info, "Created Room Successfully")
        |> redirect(to: room_path(conn, :index))
      {:error, changeset} -> render conn, "new_room.html", changeset: changeset
    end
  end
  
  def get_one(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    IO.inspect room
    render conn, "single_room.html", room: room
  end
end

defmodule SimpleChat.AuthController do
  use SimpleChat.Web, :controller
  alias SimpleChat.User
  plug Ueberauth
  
  def callback(conn, _params) do
    %{assigns: %{ueberauth_auth: auth}} = conn

    user = %{
      name: auth.info.name,
      email: auth.info.email,
      image: auth.info.image,
      provider: Atom.to_string(auth.provider),
      token: auth.credentials.token
    }

    changeset = User.changeset(%User{}, user)
    login(conn, changeset)
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: room_path(conn, :index))
  end

  defp login(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} -> conn
        |> put_flash(:info, "Login Successful")
        |> put_session(:user_id, user.id)
        |> redirect(to: room_path(conn, :index))
      {:error, reason} -> conn
        |> put_flash(:error, "Login Error: #{reason}")
        |> redirect(to: room_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end

end
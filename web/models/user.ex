defmodule SimpleChat.User do
  use SimpleChat.Web, :model
  
  schema "users" do
    field :name, :string
    field :email, :string
    field :image, :string
    field :provider, :string
    field :token, :string
    timestamps()
  end
  
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :image, :provider, :token])
    |> validate_required([:name, :email, :image, :provider, :token])
  end
end
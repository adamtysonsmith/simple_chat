defmodule SimpleChat.User do
  use SimpleChat.Web, :model
  
  @derive {Poison.Encoder, only: [:image, :name]}

  schema "users" do
    field :name, :string
    field :email, :string
    field :image, :string
    field :provider, :string
    field :token, :string
    has_many :messages, SimpleChat.Message
    has_many :rooms, SimpleChat.Room
    timestamps()
  end
  
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :image, :provider, :token])
    |> validate_required([:name, :email, :image, :provider, :token])
  end
end
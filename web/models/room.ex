defmodule SimpleChat.Room do
  use SimpleChat.Web, :model
  
  schema "rooms" do
    field :name, :string
    has_many :messages, SimpleChat.Message
    timestamps()
  end
  
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
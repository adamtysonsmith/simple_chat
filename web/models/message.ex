defmodule SimpleChat.Message do
  use SimpleChat.Web, :model
  
  @derive {Poison.Encoder, only: [:content]}

  schema "messages" do
    field :content, :string
    belongs_to :room, SimpleChat.Room
    timestamps()
  end
  
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
defmodule SimpleChat.Repo.Migrations.AddImageToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :image, :string
    end
  end
end

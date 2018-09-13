defmodule SimpleChat.Repo.Migrations.AddTimestamp do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      timestamps()
    end
  end
end

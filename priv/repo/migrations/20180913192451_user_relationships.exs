defmodule SimpleChat.Repo.Migrations.UserRelationships do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :user_id, references(:users)
    end
    
    alter table(:rooms) do
      add :user_id, references(:users)
    end
  end
end

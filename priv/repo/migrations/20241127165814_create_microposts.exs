defmodule SampleApp.Repo.Migrations.CreateMicroposts do
  use Ecto.Migration

  def change do
    create table(:microposts) do
      add :content, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:microposts, [:user_id])
  end
end

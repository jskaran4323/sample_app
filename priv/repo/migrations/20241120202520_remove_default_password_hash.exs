defmodule SampleApp.Repo.Migrations.RemoveDefaultPasswordHash do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :password_hash, :string, default: nil
    end
  end
end

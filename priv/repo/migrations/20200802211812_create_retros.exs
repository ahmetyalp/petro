defmodule Petro.Repo.Migrations.CreateRetros do
  use Ecto.Migration

  def change do
    create table(:retros) do
      add :name, :string
      add :due_date, :date
      add :team_id, references(:teams)

      timestamps()
    end
  end
end

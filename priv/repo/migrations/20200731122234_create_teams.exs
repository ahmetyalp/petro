defmodule Petro.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :company_id, references(:companies)

      timestamps()
    end
  end
end

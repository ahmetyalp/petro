defmodule Petro.Repo.Migrations.CreateCompaniesUsers do
  use Ecto.Migration

  def change do
    create table(:companies_users) do
      add :company_id, references(:companies)
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:companies_users, [:company_id, :user_id])
  end
end

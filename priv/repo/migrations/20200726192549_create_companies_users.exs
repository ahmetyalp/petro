defmodule Petro.Repo.Migrations.CreateCompaniesUsers do
  use Ecto.Migration

  def change do
    create table(:companies_users) do
      add :company_id, :integer
      add :user_id, :integer

      timestamps()
    end

    create unique_index(:companies_users, [:company_id, :user_id])
  end
end

defmodule Petro.Repo.Migrations.AddRoleToUsers do
  use Ecto.Migration

  def change do
    alter table(:companies_users) do
      add :role, :string
    end
  end
end

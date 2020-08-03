defmodule Petro.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :type, :string, null: false
      add :details, :text
      add :is_visible, :boolean, default: false
      add :auto_visible, :boolean, default: false

      add :retro_id, references(:retros, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:retro_id])
    create index(:answers, [:user_id])
  end
end

defmodule Petro.Models.Retro do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Petro.Models.Team
  alias Petro.Repo

  schema "retros" do
    field :due_date, :date
    field :name, :string
    belongs_to :team, Team

    timestamps()
  end

  @doc false
  def changeset(retro, attrs) do
    retro
    |> cast(attrs, [:name, :due_date])
    |> cast_assoc(:team)
    |> validate_required([:name, :due_date])
  end

  def all(team) do
    Repo.all(
      from r in __MODULE__,
        where: ^[team_id: team.id]
    )
  end
end

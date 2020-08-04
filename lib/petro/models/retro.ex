defmodule Petro.Models.Retro do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Petro.Models.{Team, Answer}
  alias Petro.Repo

  schema "retros" do
    field :due_date, :date
    field :name, :string

    belongs_to :team, Team
    has_one :company, through: [:team, :company]

    has_many :answers, Answer
    has_many :positive_answers, Answer, where: [type: "positive"]
    has_many :negative_answers, Answer, where: [type: "negative"]

    timestamps()
  end

  @doc false
  def changeset(retro, attrs) do
    retro
    |> cast(attrs, [:name, :due_date])
    |> validate_required([:name, :due_date])
  end

  def all(team) do
    Repo.all(
      from r in __MODULE__,
        where: ^[team_id: team.id]
    )
  end

  def get!(id, preload: preload) do
    Repo.get!(__MODULE__, id) |> Repo.preload(preload)
  end

  def get!(id) do
    Repo.get!(__MODULE__, id)
  end
end

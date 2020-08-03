defmodule Petro.Models.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias Petro.Models.{Company, Retro}

  schema "teams" do
    field :name, :string

    belongs_to :company, Company
    has_many :retros, Retro

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

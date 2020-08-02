defmodule Petro.Models.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Petro.Models.User
  alias Petro.Models.CompaniesUsers
  alias Petro.Models.Team
  alias Petro.Repo

  schema "companies" do
    field :name, :string
    many_to_many :users, User, join_through: CompaniesUsers
    has_many :teams, Team

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def change(%__MODULE__{} = company, attrs \\ %{}) do
    changeset(company, attrs)
  end

  def create!(attrs \\ %{}) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert!()
  end

  def get!(id), do: Repo.get!(__MODULE__, id)
end

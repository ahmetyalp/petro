defmodule Petro.Models.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Petro.Models.User
  alias Petro.Models.CompaniesUsers

  schema "companies" do
    field :name, :string
    many_to_many :users, User, join_through: CompaniesUsers

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> cast_assoc(:users)
    |> validate_required([:name])
  end
end

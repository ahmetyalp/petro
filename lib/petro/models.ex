defmodule Petro.Models do
  alias Petro.Models.Company
  alias Petro.Repo

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  alias Petro.Models.Team

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(company, attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:company, company)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end

  alias Petro.Models.Retro

  @doc """
  Gets a single retro.

  Raises `Ecto.NoResultsError` if the Retro does not exist.

  ## Examples

      iex> get_retro!(123)
      %Retro{}

      iex> get_retro!(456)
      ** (Ecto.NoResultsError)

  """
  def get_retro!(id), do: Repo.get!(Retro, id)

  @doc """
  Updates a retro.

  ## Examples

      iex> update_retro(retro, %{field: new_value})
      {:ok, %Retro{}}

      iex> update_retro(retro, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_retro(%Retro{} = retro, attrs) do
    retro
    |> Retro.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a retro.

  ## Examples

      iex> delete_retro(retro)
      {:ok, %Retro{}}

      iex> delete_retro(retro)
      {:error, %Ecto.Changeset{}}

  """
  def delete_retro(%Retro{} = retro) do
    Repo.delete(retro)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking retro changes.

  ## Examples

      iex> change_retro(retro)
      %Ecto.Changeset{data: %Retro{}}

  """
  def change_retro(%Retro{} = retro, attrs \\ %{}) do
    Retro.changeset(retro, attrs)
  end
end

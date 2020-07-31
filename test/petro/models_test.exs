defmodule Petro.ModelsTest do
  use Petro.DataCase

  alias Petro.Models

  describe "companies" do
    alias Petro.Models.Company

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Models.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Models.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Models.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Models.create_company(@valid_attrs)
      assert company.name == "some name"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Models.update_company(company, @update_attrs)
      assert company.name == "some updated name"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Models.update_company(company, @invalid_attrs)
      assert company == Models.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Models.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Models.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Models.change_company(company)
    end
  end

  describe "teams" do
    alias Petro.Models.Team

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Models.create_team()

      team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = Models.create_team(@valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, %Team{} = team} = Models.update_team(team, @update_attrs)
      assert team.name == "some updated name"
    end

    # test "update_team/2 with invalid data returns error changeset" do
    #   team = team_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Models.update_team(team, @invalid_attrs)
    #   assert team == Models.get_team!(team.id)
    # end

    # test "delete_team/1 deletes the team" do
    #   team = team_fixture()
    #   assert {:ok, %Team{}} = Models.delete_team(team)
    #   assert_raise Ecto.NoResultsError, fn -> Models.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Models.change_team(team)
    end
  end
end

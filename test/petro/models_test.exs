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

  describe "retros" do
    alias Petro.Models.Retro

    @valid_attrs %{due_date: ~D[2010-04-17], name: "some name"}
    @update_attrs %{due_date: ~D[2011-05-18], name: "some updated name"}
    @invalid_attrs %{due_date: nil, name: nil}

    def retro_fixture(attrs \\ %{}) do
      {:ok, retro} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Models.create_retro()

      retro
    end

    test "list_retros/0 returns all retros" do
      retro = retro_fixture()
      assert Models.list_retros() == [retro]
    end

    test "get_retro!/1 returns the retro with given id" do
      retro = retro_fixture()
      assert Models.get_retro!(retro.id) == retro
    end

    test "create_retro/1 with valid data creates a retro" do
      assert {:ok, %Retro{} = retro} = Models.create_retro(@valid_attrs)
      assert retro.due_date == ~D[2010-04-17]
      assert retro.name == "some name"
    end

    test "create_retro/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_retro(@invalid_attrs)
    end

    test "update_retro/2 with valid data updates the retro" do
      retro = retro_fixture()
      assert {:ok, %Retro{} = retro} = Models.update_retro(retro, @update_attrs)
      assert retro.due_date == ~D[2011-05-18]
      assert retro.name == "some updated name"
    end

    test "update_retro/2 with invalid data returns error changeset" do
      retro = retro_fixture()
      assert {:error, %Ecto.Changeset{}} = Models.update_retro(retro, @invalid_attrs)
      assert retro == Models.get_retro!(retro.id)
    end

    test "delete_retro/1 deletes the retro" do
      retro = retro_fixture()
      assert {:ok, %Retro{}} = Models.delete_retro(retro)
      assert_raise Ecto.NoResultsError, fn -> Models.get_retro!(retro.id) end
    end

    test "change_retro/1 returns a retro changeset" do
      retro = retro_fixture()
      assert %Ecto.Changeset{} = Models.change_retro(retro)
    end
  end

  describe "answers" do
    alias Petro.Models.Answer

    @valid_attrs %{details: "some details", type: "some type"}
    @update_attrs %{details: "some updated details", type: "some updated type"}
    @invalid_attrs %{details: nil, type: nil}

    def answer_fixture(attrs \\ %{}) do
      {:ok, answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Models.create_answer()

      answer
    end

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Models.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Models.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      assert {:ok, %Answer{} = answer} = Models.create_answer(@valid_attrs)
      assert answer.details == "some details"
      assert answer.type == "some type"
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{} = answer} = Models.update_answer(answer, @update_attrs)
      assert answer.details == "some updated details"
      assert answer.type == "some updated type"
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Models.update_answer(answer, @invalid_attrs)
      assert answer == Models.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Models.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Models.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Models.change_answer(answer)
    end
  end

  describe "answers" do
    alias Petro.Models.Answer

    @valid_attrs %{details: "some details", is_visible: true, type: "some type"}
    @update_attrs %{details: "some updated details", is_visible: false, type: "some updated type"}
    @invalid_attrs %{details: nil, is_visible: nil, type: nil}

    def answer_fixture(attrs \\ %{}) do
      {:ok, answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Models.create_answer()

      answer
    end

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Models.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Models.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      assert {:ok, %Answer{} = answer} = Models.create_answer(@valid_attrs)
      assert answer.details == "some details"
      assert answer.is_visible == true
      assert answer.type == "some type"
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{} = answer} = Models.update_answer(answer, @update_attrs)
      assert answer.details == "some updated details"
      assert answer.is_visible == false
      assert answer.type == "some updated type"
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Models.update_answer(answer, @invalid_attrs)
      assert answer == Models.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Models.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Models.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Models.change_answer(answer)
    end
  end
end

defmodule PetroWeb.RetroControllerTest do
  use PetroWeb.ConnCase

  alias Petro.Models

  @create_attrs %{due_date: ~D[2010-04-17], name: "some name"}
  @update_attrs %{due_date: ~D[2011-05-18], name: "some updated name"}
  @invalid_attrs %{due_date: nil, name: nil}

  def fixture(:retro) do
    {:ok, retro} = Models.create_retro(@create_attrs)
    retro
  end

  describe "index" do
    test "lists all retros", %{conn: conn} do
      conn = get(conn, Routes.team_retro_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Retros"
    end
  end

  describe "new retro" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.team_retro_path(conn, :new))
      assert html_response(conn, 200) =~ "New Retro"
    end
  end

  describe "create retro" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.team_retro_path(conn, :create), retro: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.team_retro_path(conn, :show, id)

      conn = get(conn, Routes.team_retro_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Retro"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.team_retro_path(conn, :create), retro: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Retro"
    end
  end

  describe "edit retro" do
    setup [:create_retro]

    test "renders form for editing chosen retro", %{conn: conn, retro: retro} do
      conn = get(conn, Routes.team_retro_path(conn, :edit, retro))
      assert html_response(conn, 200) =~ "Edit Retro"
    end
  end

  describe "update retro" do
    setup [:create_retro]

    test "redirects when data is valid", %{conn: conn, retro: retro} do
      conn = put(conn, Routes.team_retro_path(conn, :update, retro), retro: @update_attrs)
      assert redirected_to(conn) == Routes.team_retro_path(conn, :show, retro)

      conn = get(conn, Routes.team_retro_path(conn, :show, retro))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, retro: retro} do
      conn = put(conn, Routes.team_retro_path(conn, :update, retro), retro: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Retro"
    end
  end

  describe "delete retro" do
    setup [:create_retro]

    test "deletes chosen retro", %{conn: conn, retro: retro} do
      conn = delete(conn, Routes.team_retro_path(conn, :delete, retro))
      assert redirected_to(conn) == Routes.team_retro_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.team_retro_path(conn, :show, retro))
      end
    end
  end

  defp create_retro(_) do
    retro = fixture(:retro)
    %{retro: retro}
  end
end

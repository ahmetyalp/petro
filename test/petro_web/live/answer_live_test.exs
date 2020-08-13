defmodule PetroWeb.AnswerLiveTest do
  use PetroWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Petro.Models

  @create_attrs %{details: "some details", is_visible: true, type: "some type"}
  @update_attrs %{details: "some updated details", is_visible: false, type: "some updated type"}
  @invalid_attrs %{details: nil, is_visible: nil, type: nil}

  defp fixture(:answer) do
    {:ok, answer} = Models.create_answer(@create_attrs)
    answer
  end

  defp create_answer(_) do
    answer = fixture(:answer)
    %{answer: answer}
  end

  describe "Index" do
    setup [:create_answer]

    test "lists all answers", %{conn: conn, answer: answer} do
      {:ok, _index_live, html} = live(conn, Routes.answer_index_path(conn, :index))

      assert html =~ "Listing Answers"
      assert html =~ answer.details
    end

    test "saves new answer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.answer_index_path(conn, :index))

      assert index_live |> element("a", "New Answer") |> render_click() =~
               "New Answer"

      assert_patch(index_live, Routes.answer_index_path(conn, :new))

      assert index_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#answer-form", answer: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.answer_index_path(conn, :index))

      assert html =~ "Answer created successfully"
      assert html =~ "some details"
    end

    test "updates answer in listing", %{conn: conn, answer: answer} do
      {:ok, index_live, _html} = live(conn, Routes.answer_index_path(conn, :index))

      assert index_live |> element("#answer-#{answer.id} a", "Edit") |> render_click() =~
               "Edit Answer"

      assert_patch(index_live, Routes.answer_index_path(conn, :edit, answer))

      assert index_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#answer-form", answer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.answer_index_path(conn, :index))

      assert html =~ "Answer updated successfully"
      assert html =~ "some updated details"
    end

    test "deletes answer in listing", %{conn: conn, answer: answer} do
      {:ok, index_live, _html} = live(conn, Routes.answer_index_path(conn, :index))

      assert index_live |> element("#answer-#{answer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#answer-#{answer.id}")
    end
  end

  describe "Show" do
    setup [:create_answer]

    test "displays answer", %{conn: conn, answer: answer} do
      {:ok, _show_live, html} = live(conn, Routes.answer_show_path(conn, :show, answer))

      assert html =~ "Show Answer"
      assert html =~ answer.details
    end

    test "updates answer within modal", %{conn: conn, answer: answer} do
      {:ok, show_live, _html} = live(conn, Routes.answer_show_path(conn, :show, answer))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Answer"

      assert_patch(show_live, Routes.answer_show_path(conn, :edit, answer))

      assert show_live
             |> form("#answer-form", answer: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#answer-form", answer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.answer_show_path(conn, :show, answer))

      assert html =~ "Answer updated successfully"
      assert html =~ "some updated details"
    end
  end
end

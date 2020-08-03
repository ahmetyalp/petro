defmodule PetroWeb.AnswerController do
  use PetroWeb, :controller

  alias Petro.Models
  alias Petro.Models.Answer

  # def new(conn, _params) do
  #   changeset = Models.change_answer(%Answer{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{"answer" => answer_params}) do
    case Models.create_answer(answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer created successfully.")
        |> redirect(to: Routes.team_retro_answer_path(conn, :show, answer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def edit(conn, %{"id" => id}) do
  #   answer = Models.get_answer!(id)
  #   changeset = Models.change_answer(answer)
  #   render(conn, "edit.html", answer: answer, changeset: changeset)
  # end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Models.get_answer!(id)

    case Models.update_answer(answer, answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer updated successfully.")
        |> redirect(to: Routes.team_retro_answer_path(conn, :show, answer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", answer: answer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Models.get_answer!(id)
    {:ok, _answer} = Models.delete_answer(answer)

    conn
    |> put_flash(:info, "Answer deleted successfully.")
    |> redirect(to: Routes.team_retro_answer_path(conn, :index))
  end
end

defmodule PetroWeb.AnswerLive.Index do
  use PetroWeb, :live_view

  alias Petro.Models
  alias Petro.Models.{Answer, Company, Retro}

  @impl true
  def mount(params, _session, socket) do
    {:ok, socket |> assign_attributes(params) |> assign_answers()}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Answer")
    |> assign(:answer, Models.get_answer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Answer")
    |> assign(:answer, %Answer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Answers")
    |> assign(:answer, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    answer = Models.get_answer!(id)
    {:ok, _} = Models.delete_answer(answer)

    {:noreply, socket |> assign_answers()}
  end

  defp assign_attributes(socket, params) do
    retro = Retro.get!(params["retro_id"], preload: [:company, :answers])
    if connected?(socket), do: Phoenix.PubSub.subscribe(Petro.PubSub, "retro-#{retro.id}")

    cond do
      retro.company.id == String.to_integer(params["company_id"]) ->
         socket
         |> assign(:current_company, Company.get!(params["company_id"]))
         |> assign(:retro, retro)
        #  |> assign(:user_id, socket.private[:assign_new][0][:current_user].id)
         |> apply_action(socket.assigns.live_action, params)

      true ->
        socket |> redirect(to: Routes.dashboard_path(socket, :index))
    end
  end

  defp assign_answers(socket) do
    socket |> assign(:answers, socket.assigns.retro.answers)
  end

  @impl true
  def handle_info({:updated, answer_id}, socket) do
    {:noreply, socket |> put_flash(:info, "answer #{answer_id} updated")}
  end

  @impl true
  def handle_info({:created, answer_id}, socket) do
    {:noreply, socket |> put_flash(:info, "answer #{answer_id} created")}
  end
end

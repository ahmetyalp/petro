defmodule PetroWeb.RetroLive do
  use PetroWeb, :live_view

  alias Petro.Models.{Retro, User, Company, Answer}
  alias Petro.Repo

  def render(assigns) do
    PetroWeb.RetroView.render("live.html", assigns)
  end

  def mount(:not_mounted_at_router, session, socket) do
    %{"company_id" => company_id, "user_id" => user_id, "retro_id" => retro_id} = session

    retro = Retro.get!(retro_id, preload: [:positive_answers, :negative_answers])
    user = Repo.get!(User, user_id)
    company = Repo.get!(Company, company_id)

    if connected?(socket), do: Phoenix.PubSub.subscribe(Petro.PubSub, "retro-#{retro.id}")

    {:ok,
     socket
     |> assign(:retro, retro)
     |> assign(:current_company, company)
     |> assign(:current_user, user)}
  end

  def handle_event("ahmet", _value, socket) do
    IO.puts("bana basildi")
    # dont do this
    {:noreply,
     socket
     |> push_redirect(
       to:
         Routes.retro_path(socket, :live, socket.assigns.current_company, socket.assigns.retro.id)
     )}
  end

  def handle_event("make_visible", %{"answerid" => answer_id}, socket) do
    answer =
      Repo.get!(Answer, answer_id) |> Answer.changeset(%{"is_visible" => true}) |> Repo.update!()

    Phoenix.PubSub.broadcast(
      Petro.PubSub,
      "retro-#{answer.retro_id}",
      {:answer_updated, answer_id}
    )

    {:noreply, socket}
  end

  def handle_info({:answer_updated, answer_id}, socket) do
    {:noreply, socket |> put_flash(:info, "answer #{answer_id} updated")}
  end
end

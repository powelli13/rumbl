defmodule RumblWeb.SupportController do
  use RumblWeb, :controller

  alias Rumbl.Support
  alias Rumbl.Support.HelpRequest

  def new(conn, _params) do
    changeset = Support.change_help_request(%HelpRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"help_request" => help_request_params}) do
    case Support.create_help_request(help_request_params) do
      {:ok, _help_request} ->
        conn
        |> put_flash(:info, "Support help request created!")
        |> redirect(to: Routes.support_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    help_request = Support.get_help_request!(id)
    changeset = Support.change_help_request(help_request)
    render(conn, "edit.html", help_request: help_request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "help_request" => help_request_params}) do
    help_request = Support.get_help_request!(id)

    case Support.update_help_request(help_request, help_request_params) do
      {:ok, _help_request} ->
        conn
        |> put_flash(:info, "Support help request resolved!")
        |> redirect(to: Routes.support_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", help_request: help_request, changeset: changeset)
    end
  end

  def index(conn, _params) do
    requests = Support.list_help_requests()
    render(conn, "index.html", requests: requests)
  end
end
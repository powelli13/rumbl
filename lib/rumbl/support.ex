defmodule Rumbl.Support do
  alias Rumbl.Repo
  alias Rumbl.Support.HelpRequest

  def list_help_requests() do
    Repo.all(HelpRequest)
  end

  def change_help_request(%HelpRequest{} = help_request, attrs \\ %{}) do
    HelpRequest.changeset(help_request, attrs)
  end

  def create_help_request(attrs \\ %{}) do
    %HelpRequest{}
    |> change_help_request(attrs)
    |> Repo.insert()
  end

  def get_help_request!(id) do
    Repo.get!(HelpRequest, id)
  end

  def update_help_request(%HelpRequest{} = help_request, attrs \\ %{}) do
    help_request
    |> change_help_request(attrs)
    |> Repo.update()
  end
end
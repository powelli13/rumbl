defmodule Rumbl.Support do
  alias Rumbl.Repo
  alias Rumbl.Support.HelpRequest

  def list_help_requests() do
    Repo.all(HelpRequest)
  end
end
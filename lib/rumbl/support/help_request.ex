defmodule Rumbl.Support.HelpRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "help_requests" do
    field :summary, :string
    field :details, :string
    field :resolved, :boolean
  end
end
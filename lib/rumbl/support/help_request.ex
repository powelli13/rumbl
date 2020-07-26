defmodule Rumbl.Support.HelpRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "help_requests" do
    field :summary, :string
    field :details, :string
    field :resolved, :boolean
  end

  def changeset(help_request, attrs) do
    help_request
    |> cast(attrs, [:summary, :details])
    |> validate_required([:summary, :details])
  end
end
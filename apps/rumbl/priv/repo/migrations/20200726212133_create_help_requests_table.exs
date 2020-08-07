defmodule Rumbl.Repo.Migrations.CreateHelpRequestsTable do
  use Ecto.Migration

  def change do
    create table(:help_requests) do
      add :summary, :string
      add :details, :string
      add :resolved, :boolean
    end
  end
end

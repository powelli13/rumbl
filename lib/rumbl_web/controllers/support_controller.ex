defmodule RumblWeb.SupportController do
  use RumblWeb, :controller

  alias Rumbl.Support

  def index(conn, _params) do
    requests = Support.list_help_requests()
    render(conn, "index.html", requests: requests)
  end
end
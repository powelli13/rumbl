defmodule RumblWeb.AutoComplete do
  use Phoenix.LiveView

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket = socket
      |> assign(:query, "")
      |> assign(:matches, [])
      |> assign(:loading, false)
      |> assign(:result, "")

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~L"""
    <form phx-change="suggest" phx-submit="search">
      <input type="text" name="q" value="<%= @query %>"
        list="matches" placeholder="Search..."
        <%= if @loading, do: "readonly" %>/>
      <datalist id="matches">
        <%= for match <- @matches do %>
          <option value="<%= match %>"><%= match %></option>
        <% end %>
      </datalist>
      <%= if @result do %><pre><%= @result %></pre><% end %>
    </form>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("suggest", %{"q" => query}, socket)
    when byte_size(query) <= 100 do
    
    words = ["alpha", "beta", "gamma", "delta", "epsilon"]
    {:noreply, assign(socket, matches: words)}
  end

  @impl Phoenix.LiveView
  def handle_event("search", %{"q" => query}, socket)
    when byte_size(query) <= 100 do

    send(self(), {:search, query})
    {
      :noreply,
      assign(socket,
        query: query,
        result: "Searching...",
        loading: true,
        matches: [])
    }
  end

  @impl Phoenix.LiveView
  def handle_info({:search, query}, socket) do
    #do search
    {:noreply, socket}
  end
end
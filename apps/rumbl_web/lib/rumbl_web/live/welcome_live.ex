defmodule RumblWeb.WelcomeLive do
  use Phoenix.LiveView

  # This assigns cannot be marked as unused
  @impl Phoenix.LiveView
  def render(assigns) do
    ~L"""
    <div>
      <h2><%= @salutation %></h2>
      <h4>Received Items</h4>
      <%= for item <- @items do %>
        <div><%= item %></div>
      <% end %>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_info(:add_item, socket) do
    item_count = length(socket.assigns[:items])

    {:noreply, update(socket,
      :items,
      fn items -> ["new #{item_count}" | items] end)}
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    salutation = "Welcome to LiveView, from the Programming Phoenix team!"

    if connected?(socket) do
      # register
      # :timer.send_interval(3000, self(), :add_item)
      
    end

    {:ok, assign(socket,
      salutation: salutation,
      connected: connected?(socket),
      items: [])
    }
  end
end
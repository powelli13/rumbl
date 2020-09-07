defmodule RumblWeb.WelcomeLive do
  use Phoenix.LiveView

  # This assigns cannot be marked as unused
  @impl Phoenix.LiveView
  def render(assigns) do
    ~L"""
    <div>
      <h2><%= @salutation %></h2>
      <h2>we are <%= @connected %></h2>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    salutation = "Welcome to LiveView, from the Programming Phoenix team!"
    {:ok, assign(socket, salutation: salutation, connected: connected?(socket))}
  end
end
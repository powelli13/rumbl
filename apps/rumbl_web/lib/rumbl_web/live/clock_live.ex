defmodule RumblWeb.ClockLive do
  use Phoenix.LiveView
  import Calendar.Strftime

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    connected = connected?(socket)

    if connected do
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, put_date(socket) |> assign(connected: connected)}
  end

  defp put_date(socket) do
    assign(socket, date: :calendar.local_time())
  end

  @impl Phoenix.LiveView
  def handle_info(:tick, socket) do
    {:noreply, put_date(socket)}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~L"""
    <div>hi there we are <%= @connected %></div>
    <div>
      <h2>It is <%= strftime!(@date, "%r")%></h2>
    </div>
    """
  end
end
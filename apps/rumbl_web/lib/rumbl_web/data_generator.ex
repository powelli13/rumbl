defmodule RumblWeb.DataGenerator do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_arg) do
    :timer.send_interval(3000, self(), :send_data)
    {:ok, []}
  end

  @impl GenServer
  def handle_info(:send_data, state) do
    Registry.dispatch(LiveViewRegistry, "welcome_test", fn entries ->
      for {pid, _} <- entries do
        send(pid, {:new_data, Ecto.UUID.generate()})
      end
    end)
    
    {:noreply, state}
  end
end
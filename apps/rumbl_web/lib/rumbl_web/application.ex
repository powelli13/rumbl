defmodule RumblWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RumblWeb.Telemetry,
      # Start the Endpoint (http/https)
      RumblWeb.Endpoint,
      # Start Presence Tracking for Channels
      RumblWeb.Presence,
      # Start a worker by calling: RumblWeb.Worker.start_link(arg)
      # {RumblWeb.Worker, arg}
      # Simple test Registry usage in order to explore
      # using Registry as a PubSub to LiveView processes
      {Registry, keys: :unique, name: LiveViewRegistry},
      # Test proces to generate data and send it to the
      # LiveView
      RumblWeb.DataGenerator
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RumblWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RumblWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

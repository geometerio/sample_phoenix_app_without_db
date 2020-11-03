defmodule SamplePhoenixAppWithoutDb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SamplePhoenixAppWithoutDbWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SamplePhoenixAppWithoutDb.PubSub},
      # Start the Endpoint (http/https)
      SamplePhoenixAppWithoutDbWeb.Endpoint
      # Start a worker by calling: SamplePhoenixAppWithoutDb.Worker.start_link(arg)
      # {SamplePhoenixAppWithoutDb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SamplePhoenixAppWithoutDb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SamplePhoenixAppWithoutDbWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

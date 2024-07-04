defmodule ShadcnElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ShadcnElixirWeb.Telemetry,
      ShadcnElixir.Repo,
      {DNSCluster, query: Application.get_env(:shadcn_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ShadcnElixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ShadcnElixir.Finch},
      # Start a worker by calling: ShadcnElixir.Worker.start_link(arg)
      # {ShadcnElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      ShadcnElixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ShadcnElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShadcnElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

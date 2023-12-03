defmodule KdsTreningy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KdsTreningyWeb.Telemetry,
      KdsTreningy.Repo,
      {DNSCluster, query: Application.get_env(:kds_treningy, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: KdsTreningy.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: KdsTreningy.Finch},
      # Start a worker by calling: KdsTreningy.Worker.start_link(arg)
      # {KdsTreningy.Worker, arg},
      # Start to serve requests, typically the last entry
      KdsTreningyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KdsTreningy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KdsTreningyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

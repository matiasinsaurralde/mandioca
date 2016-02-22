defmodule Mandioca do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Mandioca.Endpoint, []),
      # Start the Ecto repository
      supervisor(Mandioca.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(Mandioca.Worker, [arg1, arg2, arg3]),
      # supervisor(Mandioca.Influx.child_spec,  [])
    ]

    Mandioca.Cache.prepare()

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mandioca.Supervisor]
    Supervisor.start_link(children, opts)

    Supervisor.start_link([ Mandioca.Influx.child_spec ], strategy: :one_for_one )

  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Mandioca.Endpoint.config_change(changed, removed)
    :ok
  end

end

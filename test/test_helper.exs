ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Mandioca.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Mandioca.Repo --quiet)



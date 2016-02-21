# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mandioca.Repo.insert!(%Mandioca.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Mandioca.Repo.insert!(%Mandioca.API{name: "testapi", endpoint_url: "http://127.0.0.1", slug: "slug"})

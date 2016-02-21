defmodule Mandioca.API do
  use Mandioca.Web, :model

  schema "apis" do
    field :name, :string
    field :endpoint_url, :string
    field :slug, :string

    timestamps
  end

  @required_fields ~w(name endpoint_url slug)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

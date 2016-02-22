defmodule Mandioca.APIController do
  use Mandioca.Web, :controller

  alias Mandioca.API

  plug :scrub_params, "api" when action in [:create, :update]

  def index(conn, _params) do
    apis = Repo.all(API)
    render(conn, "index.json", apis: apis)
  end

  def create(conn, %{"api" => api_params}) do
    changeset = API.changeset(%API{}, api_params)

    case Repo.insert(changeset) do
      {:ok, api} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_path(conn, :show, api))
        |> render("show.json", api: api)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Mandioca.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    api = Repo.get!(API, id)
    render(conn, "show.json", api: api)
  end

  def update(conn, %{"id" => id, "api" => api_params}) do
    api = Repo.get!(API, id)
    changeset = API.changeset(api, api_params)

    case Repo.update(changeset) do
      {:ok, api} ->
        render(conn, "show.json", api: api)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Mandioca.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    api = Repo.get!(API, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(api)

    send_resp(conn, :no_content, "")
  end

  def stats(conn, %{"id" => id} ) do
    api = Repo.get!(API, id)
    result = "SELECT count(elapsed_time) from \"#{api.slug}\" WHERE time >= now() - 30m GROUP by http_method, time(10m) ORDER by time ASC"
      |> Mandioca.Influx.query( database: "mandioca" )
      |> IO.inspect(); send self(), { :influx_response, result }

      receive do
        {:influx_response, response} -> IO.inspect(result)
          conn
          |> send_resp(200,Poison.encode!(result))
      end
  end
end

defmodule Mandioca.Proxy do

  use Plug.Router

  import Ecto.Query, only: [from: 2]

  plug :match
  plug :dispatch

  def init( options ) do
    options
  end

  def find_by_slug( slug ) do
    query = from a in Mandioca.API, where: a.slug == ^slug
    Mandioca.Repo.all( query )
  end

  def handle_request( conn, api ) do
    IO.inspect( conn )

    path = String.replace( conn.request_path, "/#{api.slug}", "" )

    
    send_resp( conn, 200, ":)")
  end

  match _ do
    slug = Enum.at( conn.path_info, 0 )
    results = find_by_slug( slug )

    if length(results) > 0 do
      api = Enum.at( results, 0 )
    end

    if api do
      handle_request( conn, api )
    else
      send_resp( conn, 404, "Not Found")
    end

  end
end

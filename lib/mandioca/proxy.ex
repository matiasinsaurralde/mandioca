defmodule Mandioca.Proxy do

  use Plug.Router

  import Ecto.Query, only: [from: 2]

  plug :match
  plug :dispatch

  def init( options ) do
    options
  end

  def find_by_slug( slug ) do
    # query = from a in Mandioca.API, where: a.slug == ^slug
    # Mandioca.Repo.all( query )
    [%{slug: "TestAPI", endpoint_url: "http://165.225.129.68/api"}]
  end

  def handle_request( conn, api ) do
    path = String.replace( conn.request_path, "/#{api.slug}", "" )
    url = "#{api.endpoint_url}#{path}"

    status = 404
    body = "Error"

    cached_item = Mandioca.Cache.exists( url )

    case conn.method do
      "GET" ->
          if cached_item do
            send self(), { :tesla_response, cached_item }
          else
            Tesla.get( url, respond_to: self )
          end

      "POST" ->
          Tesla.post( url, Poison.encode!(conn.body_params), respond_to: self )
      _ ->
          send self(), { :tesla_response, %{ :status => 405, :body => 'Method not allowed', :headers => [] } }
    end

    receive do
      {:tesla_response, res} ->

        if conn.method == "GET"  do
          Mandioca.Cache.store( url, res )
        end

        conn = %{conn | resp_headers: Enum.into(res.headers, [])}

        conn
        |> merge_resp_headers( [{ "server", "Mandioca" } ] )
        |> send_resp( res.status, res.body )
    end

  end

  match _ do
    slug = Enum.at( conn.path_info, 0 )
    results = find_by_slug( slug )

    api = nil

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

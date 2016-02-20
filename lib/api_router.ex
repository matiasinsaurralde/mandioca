defmodule SimplePlug.APIRouter do
  use Plug.Router
  require Logger

  # plug Plug.Logger
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def proxy_request(conn) do
  end

  match _ do

    api_name = Enum.at( conn.script_name, 1 )

    api = SimplePlug.API.lookup_api_name( api_name )

    # IO.inspect(api)

    # IO.inspect( conn.request_path )

    url = String.replace( conn.request_path, api.mount_path, api.endpoint_url )

    cached = SimplePlug.Cache.exists( url )

    if cached == [] do
      proxy_request = Tesla.get( url )
      spawn fn -> SimplePlug.Cache.store( url, proxy_request.body ) end
      body = proxy_request.body
    else
      body = cached
    end

    send_resp( conn, 200, body )
    # send_resp(conn, 404, "API Name => #{api_name}")
  end

end

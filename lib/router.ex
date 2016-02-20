defmodule SimplePlug.Router do
  use Plug.Router
  require Logger

  # plug Plug.Logger
  plug :match
  plug :dispatch

  def init(options) do
    # initialize your options here

    options
  end


  get "/" do
    IO.puts( "GET" )
    send_resp(conn,200,"")
  end

  forward "/api/:api_name", to: SimplePlug.APIRouter

  match _ do
    IO.inspect(conn.params)
    send_resp(conn, 404, "oops")
  end

end

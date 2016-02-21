defmodule Mandioca.Proxy do
  use Plug.Router

  plug :match
  plug :dispatch

  def init( options ) do
    options
  end

  match _ do
    IO.puts( "Mandioca.Proxy :P")
    send_resp( conn, 200, "hi" )
  end
end

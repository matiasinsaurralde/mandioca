defmodule SimplePlug.API do
  defstruct name: "", endpoint_url: "", mount_path: ""

  def load_apis() do
    apis = :ets.new( :apis, [:set, :public, :named_table])
    :ets.insert( :apis, { "SongApi", %SimplePlug.API{ name: "SongApi", endpoint_url: "http://127.0.0.1:3000", mount_path: "/api/SongApi" } } )
  end

  def lookup_api_name( api_name ) do
    :ets.lookup_element( :apis, api_name, 2)
  end

  def lookup_api_mount_path( mount_path ) do
    :ets.lookup_element( :apis, mount_path, 3)
  end

end

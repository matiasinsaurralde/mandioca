defmodule SimplePlug.API do
  defstruct name: "", endpoint_url: "", mount_path: ""

  def load_apis() do
    apis = :ets.new( :apis, [:set, :public, :named_table])
    :ets.insert( :apis, { "TestAPI", %SimplePlug.API{ name: "TestAPI", endpoint_url: "http://165.225.129.68/api", mount_path: "/api/TestAPI" } } )
  end

  def lookup_api_name( api_name ) do
    :ets.lookup_element( :apis, api_name, 2)
  end

  def lookup_api_mount_path( mount_path ) do
    :ets.lookup_element( :apis, mount_path, 3)
  end

end

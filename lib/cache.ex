defmodule SimplePlug.Cache do

  # :ets.new( :http_cache, [:set, :public, :named_table])

  # try do
  #   :ets.lookup_element( :http_cache, "lol", 0 )
   #rescue
#     e in ArgumentError -> IO.puts( "lol doesnt exist" )
  # end

  def prepare_cache() do
    :ets.new( :http_cache, [:set, :public, :named_table])
  end

  def exists( url ) do
    try do
      :ets.lookup_element( :http_cache, url, 2 )
    rescue
      e in ArgumentError -> []
    end
  end

  def store( url, body ) do
    :ets.insert(:http_cache,{ url, body })
  end

end

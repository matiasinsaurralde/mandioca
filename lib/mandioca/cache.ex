defmodule Mandioca.Cache do

  def prepare() do
    :ets.new( :mandioca_cache, [ :set, :public, :named_table ] )
  end

  def exists( url ) do
    try do
      :ets.lookup_element( :mandioca_cache, url, 2 )
    rescue
      e in ArgumentError -> nil
    end
  end

  def store( url, response ) do
    :ets.insert( :mandioca_cache, { url, response } )
  end

end
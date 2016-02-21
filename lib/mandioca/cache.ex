defmodule Mandioca.Cache do

  @expiration_secs 30
  @table :mandioca_cache

  defstruct created_at: 0, expires_at: 0

  def prepare() do
    :ets.new( @table, [ :set, :public, :named_table ] )
  end

  def exists( url ) do
    try do
      element = :ets.lookup_element( @table, url, 2 )

      if should_purge( url ) do
         purge( url )
      end

      element
    rescue
      e in ArgumentError -> nil
    end
  end

  def should_purge( url ) do
    item = :ets.lookup_element( @table, url, 3 )
    :os.system_time() >= item.expires_at
  end

  def purge( url ) do
    :ets.delete( @table, url )
  end

  def store( url, response ) do

    item = %Mandioca.Cache{ created_at: :os.system_time(), expires_at: :os.system_time() +  + ( 1000000000 * @expiration_secs ) }

    :ets.insert( @table, { url, response, item } )
  end

end

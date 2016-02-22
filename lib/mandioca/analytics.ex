defmodule Mandioca.Analytics do
  def record_hit( api, conn, res, elapsed_time, cached_item ) do
    # IO.puts( "record_hit()")
    # IO.inspect(api)
    # IO.inspect(conn)
    # IO.inspect(res)

    is_cached = false

    if cached_item do
      is_cached = true
    end

    point = %{ database: "mandioca",
               points: [%{
                 measurement: api.slug,
                 tags: %{ http_method: conn.method },
                 fields: %{ elapsed_time: elapsed_time, cached: is_cached }
               }]}
    |> Mandioca.Influx.write([ async: true ])

  end
end

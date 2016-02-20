SimplePlug
==========

## Dependencies

```mix do deps.get, compile```

## Running

```iex -S mix```

## Benchmark (using wrk2)

```wrk -R 50000 -d 15s -t 4 -c 20 http://localhost:4000/```

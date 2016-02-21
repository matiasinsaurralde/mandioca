Mandioca
==========

Mandioca is an experimental API gateway written in Elixir.

This project is part of the [hack.summit() Virtual Hackathon](https://www.koding.com/Hackathon).

## Dependencies

```mix do deps.get, compile```

## Running

```iex -S mix```

## Benchmark (using wrk2)

```wrk -R 50000 -d 15s -t 4 -c 20 http://localhost:4000/```

## Team "Mandioca"

- [Mauro Gavilan](https://github.com/mauroot)
- [Matias Insaurralde](https://github.com/matiasinsaurralde)

Based on this skeleton: https://github.com/dendeer/simple_plug

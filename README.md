# GenServer.reply example

Dependencies: Redis

Setup:
```
mix deps.get
```

Start up a redis instance
```
redis-server
```

Run the benchmarks:
```
for f in bench*.exs; do mix run $f; done
```
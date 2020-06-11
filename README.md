[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/joshuawscott/example_async)

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
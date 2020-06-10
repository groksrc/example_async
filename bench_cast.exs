{:ok, r} = Redix.start_link()
input_file = "data/input.txt"

Redix.command!(r, ["FLUSHALL"])

{ingest_time, _} =
  :timer.tc(fn ->
    ExampleAsync.ingest(input_file, :set_cast)
  end)

{get_time, _} =
  :timer.tc(fn ->
    ExampleAsync.Saver.get("dummy")
  end)

IO.puts("set with cast: #{Float.round(ingest_time / 1_000, 1)} ms")
IO.puts("get call: #{Float.round(get_time / 1_000, 1)} ms")
IO.puts("total: #{Float.round((ingest_time + get_time) / 1_000, 1)} ms")
IO.puts("")

Redix.command!(r, ["FLUSHALL"])

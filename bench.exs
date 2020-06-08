{:ok, r} = Redix.start_link()
input_file = "data/input.txt"

Redix.command!(r, ["FLUSHALL"])

{time, _} =
  :timer.tc(fn ->
    input_file
    |> File.stream!()
    |> Enum.each(fn key ->
      key = String.trim(key)
      val = String.replace(key, "A", "B")
      ExampleAsync.Saver.set_call(key, val)
    end)

    ExampleAsync.Saver.get("key_1")
  end)

IO.puts("set with call: #{time / 1_000} ms")

Redix.command!(r, ["FLUSHALL"])

{time, _} =
  :timer.tc(fn ->
    input_file
    |> File.stream!()
    |> Enum.each(fn key ->
      key = String.trim(key)
      val = String.replace(key, "A", "B")
      ExampleAsync.Saver.set_cast(key, val)
    end)

    ExampleAsync.Saver.get("key_1")
  end)

IO.puts("set with cast: #{time / 1_000} ms")

Redix.command!(r, ["FLUSHALL"])

{time, _} =
  :timer.tc(fn ->
    input_file
    |> File.stream!()
    |> Enum.each(fn key ->
      key = String.trim(key)
      val = String.replace(key, "A", "B")
      ExampleAsync.Saver.set_call_async(key, val)
    end)

    ExampleAsync.Saver.get("key_1")
  end)

IO.puts("set with call + early reply: #{time / 1_000} ms")

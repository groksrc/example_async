{time, "val_1"} =
  :timer.tc(fn ->
    for x <- 1..1_000 do
      :timer.sleep(1)
      ExampleAsync.Saver.set("key_#{x}", "val_#{x}")
    end

    ExampleAsync.Saver.get("key_1")
  end)

IO.puts("Took #{time / 1_000} ms")

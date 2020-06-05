defmodule ExampleAsyncTest do
  use ExUnit.Case
  doctest ExampleAsync

  test "greets the world" do
    assert ExampleAsync.hello() == :world
  end
end

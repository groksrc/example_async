defmodule ExampleAsync.Saver do
  use GenServer
  # Wrapper to make starting this module easier
  def start_link(initial_data) do
    GenServer.start_link(__MODULE__, initial_data, name: __MODULE__)
  end

  # Set up initial state of the process here
  def init(initial_data) do
    {:ok, initial_data}
  end

  # Public API
  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # GenServer callback for GenServer.call
  def handle_call({:set, key, value}, _from, state) do
    # Simulate a 1ms round trip to an external database
    :timer.sleep(1)
    state = Map.put(state, key, value)
    {:reply, :ok, state}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end
end

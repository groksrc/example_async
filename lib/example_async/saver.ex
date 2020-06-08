defmodule ExampleAsync.Saver do
  use GenServer
  # Wrapper to make starting this module easier
  def start_link(initial_data) do
    GenServer.start_link(__MODULE__, initial_data, name: __MODULE__)
  end

  # Set up initial state of the process here
  def init(_initial_data) do
    {:ok, redis} = Redix.start_link()
    {:ok, redis}
  end

  # Public API
  def set_call(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def set_cast(key, value) do
    GenServer.cast(__MODULE__, {:set, key, value})
  end

  def set_call_async(key, value) do
    GenServer.call(__MODULE__, {:set_async, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key}, :infinity)
  end

  def handle_call({:set, key, value}, _from, redis) do
    retval = Redix.command!(redis, ["SET", key, value])
    {:reply, retval, redis}
  end

  def handle_call({:set_async, key, value}, from, redis) do
    GenServer.reply(from, :ok)

    Redix.command!(redis, ["SET", key, value])
    {:noreply, redis}
  end

  def handle_call({:get, key}, _from, redis) do
    retval = Redix.command!(redis, ["GET", key])
    {:reply, retval, redis}
  end

  # GenServer callback for GenServer.call
  def handle_cast({:set, key, value}, redis) do
    Redix.command!(redis, ["SET", key, value])
    {:noreply, redis}
  end
end

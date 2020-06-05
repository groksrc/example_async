defmodule ExampleAsync.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {ExampleAsync.Saver, %{}}
    ]

    opts = [strategy: :one_for_one, name: ExampleAsync.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

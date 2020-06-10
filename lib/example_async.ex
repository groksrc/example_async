defmodule ExampleAsync do
  @spec ingest(binary, atom) :: :ok
  def ingest(input_file, method) do
    input_file
    |> File.stream!()
    |> Enum.each(fn original_key ->
      trimmed_key = String.trim(original_key)
      hashed_key = Base.encode16(:crypto.hash(:sha3_512, trimmed_key))

      :erlang.apply(ExampleAsync.Saver, method, [hashed_key, trimmed_key])
    end)

    :ok
  end
end

defmodule Day01 do
  @spec pairs([integer()]) :: [{integer(), integer()}]
  defp pairs([x | [y | xs]]) do
    [{x, y} | pairs([y | xs])]
  end

  defp pairs(_), do: []

  @spec countIncreases([integer()]) :: integer()
  defp countIncreases(xs) do
    pairs(xs) |> Enum.map(fn {x, y} -> y > x end) |> Enum.count(fn x -> x end)
  end

  @spec triples([integer()]) :: [{integer(), integer(), integer()}]
  defp triples([x | [y | [z | xs]]]) do
    [{x, y, z} | triples([y | [z | xs]])]
  end

  defp triples(_), do: []

  @spec countWindowIncreases([integer()]) :: integer()
  defp countWindowIncreases(xs) do
    triples(xs) |> Enum.map(fn {x, y, z} -> x + y + z end) |> countIncreases()
  end

  @spec main :: :ok
  def main() do
    case File.read("res/day01.dat") do
      {:ok, content} ->
        String.split(content)
        |> Enum.map(fn x -> Integer.parse(x) end)
        |> Enum.map(fn {n, _} -> n end)
        |> countWindowIncreases()
        |> IO.puts()

      {:error, reason} ->
        IO.puts("Failed to read: #{reason}")
    end
  end
end

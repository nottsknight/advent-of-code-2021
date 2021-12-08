defmodule Day01 do
  @spec pairs([integer()]) :: [{integer(), integer()}]
  defp pairs([x | [y | xs]]) do
    [{x, y} | pairs([y | xs])]
  end

  defp pairs(_) do
    []
  end

  @spec countIncreases([integer()]) :: integer()
  defp countIncreases(xs) do
    pairs(xs) |> Enum.map(fn {x, y} -> y > x end) |> Enum.count(fn x -> x end)
  end

  @spec main :: :ok
  def main() do
    case File.read("res/day01.dat") do
      {:ok, content} ->
        String.split(content)
        |> Enum.map(fn x -> Integer.parse(x) end)
        |> countIncreases()
        |> IO.puts()

      {:error, reason} ->
        IO.puts("Failed to read: #{reason}")
    end
  end
end

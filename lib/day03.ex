defmodule Day03 do
  use Bitwise, only_operators: true

  @spec parse(String.t()) :: [integer()]
  defp parse(str) do
    String.graphemes(str) |> Enum.map(&String.to_integer/1)
  end

  @spec addTwoLists([integer()], [integer()]) :: [integer()]
  defp addTwoLists([x | xs], [y | ys]) do
    [x + y | addTwoLists(xs, ys)]
  end

  defp addTwoLists([], _), do: []

  defp addTwoLists(_, []), do: []

  @spec calcRates([integer()]) :: {integer(), integer()}
  defp calcRates(xs) do
    threshold = Enum.count(xs) / 2

    gamma =
      Enum.map(xs, fn b -> if b >= threshold, do: 1, else: 0 end)
      |> Enum.reduce(fn x, y -> (y <<< 1) + x end)

    {gamma, ~~~gamma}
  end

  @spec main :: :ok
  def main do
    case File.read("res/day03.dat") do
      {:ok, content} ->
        String.split(content)
        |> Enum.map(&parse/1)
        |> Enum.reduce(&addTwoLists/2)
        |> calcRates()
        |> IO.puts()

      {:error, reason} ->
        IO.puts("Failed to read: #{reason}")
    end
  end
end

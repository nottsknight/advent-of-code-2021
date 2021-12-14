defmodule Day03 do
  @spec parse(String.t()) :: [integer()]
  defp parse(str) do
    String.graphemes(str) |> Enum.map(&String.to_integer/1)
  end

  @spec add_lists([integer()], [integer()]) :: [integer()]
  defp add_lists([x | xs], [y | ys]) do
    [x + y | add_lists(xs, ys)]
  end

  defp add_lists([], _), do: []
  defp add_lists(_, []), do: []

  @spec gamma([integer()]) :: [integer()]
  defp gamma(xs) do
    n = Enum.count(xs) / 2
    Enum.reduce(xs, &add_lists/2) |> Enum.map(fn x -> if x > n, do: 1, else: 0 end)
  end

  @spec epsilon_from_gamma([integer()]) :: [integer()]
  defp epsilon_from_gamma(bs) do
    Enum.map(bs, fn b -> if b == 1, do: 0, else: 1 end)
  end

  @spec bits_to_integer([integer()]) :: integer()
  defp bits_to_integer(bs) do
    Enum.reduce(bs, fn b, acc -> (acc * 2) + b end)
  end

  @spec calc_values([integer()]) :: {integer(), integer()}
  defp calc_values(xs) do
    gamma_bits = gamma(xs)
    epsilon_bits = epsilon_from_gamma(gamma_bits)
    {bits_to_integer(gamma_bits), bits_to_integer(epsilon_bits)}
  end

  defp calc_result({gamma, epsilon}) do
    gamma * epsilon
  end

  @spec main :: :ok | [integer]
  def main do
    case File.read("res/day03.dat") do
      {:error, reason} -> IO.puts(:stderr, "Failed to read: #{reason}")
      {:ok, content} -> String.split(content) |> Enum.map(&parse/1) |> calc_values() |> calc_result() |> IO.puts()
    end
  end
end

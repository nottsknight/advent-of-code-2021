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
    Enum.reduce(xs, &add_lists/2) |> Enum.map(fn x -> if x >= n, do: 1, else: 0 end)
  end

  @spec epsilon_from_gamma([integer()]) :: [integer()]
  defp epsilon_from_gamma(bs) do
    Enum.map(bs, fn b -> if b == 1, do: 0, else: 1 end)
  end

  @spec bits_to_integer([integer()]) :: integer()
  defp bits_to_integer(bs) do
    Enum.reduce(bs, fn b, acc -> acc * 2 + b end)
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

  @spec bit_filter([integer()], integer(), integer()) :: boolean()
  defp bit_filter([b | _], mask, 0) do
    b == mask
  end

  defp bit_filter([_ | bs], mask, idx) do
    bit_filter(bs, mask, idx - 1)
  end

  @spec get_rating([[integer()]], [integer()], integer()) :: integer()
  defp get_rating([x], _, _) do
    bits_to_integer(x)
  end

  defp get_rating(values, [m | mask], idx) do
    new_values = Enum.filter(values, fn val -> bit_filter(val, m, idx) end)
    get_rating(new_values, mask, idx + 1)
  end

  @spec find_ratings([[integer()]]) :: {integer(), integer()}
  defp find_ratings(values) do
    o2_filter = gamma(values)
    o2_rating = get_rating(values, o2_filter, 0)
    co2_filter = epsilon_from_gamma(o2_filter)
    co2_rating = get_rating(values, co2_filter, 0)
    {o2_rating, co2_rating}
  end

  @spec main :: :ok
  def main do
    case File.read("res/day03.dat") do
      {:error, reason} ->
        IO.puts(:stderr, "Failed to read: #{reason}")

      {:ok, content} ->
        String.split(content)
        |> Enum.map(&parse/1)
        |> find_ratings()
        |> calc_result()
        |> IO.puts()
    end
  end
end

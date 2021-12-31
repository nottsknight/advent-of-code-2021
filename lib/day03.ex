defmodule Day03.Part1 do
  @moduledoc "Solution to day 3 part 1"

  @doc ~S"""
  Convert a string of a binary number to a list of its bits.

  ## Examples

      iex> Day03.Part1.chars_to_ints("10101")
      [1, 0, 1, 0, 1]

  """
  @spec chars_to_ints(String.t()) :: [integer()]
  def chars_to_ints(str) do
    String.graphemes(str) |> Enum.map(&String.to_integer/1)
  end

  @doc ~S"""
  Add two lists of integers element-wise. If the lists are of different
  lengths, the result has the same length as the shortest input.

  ## Examples

      iex> Day03.Part1.add_lists([1,0,1,1], [0,1,1,1])
      [1,1,2,2]

      iex> Day03.Part1.add_lists([1,0], [1,1,0])
      [2,1]

      iex> Day03.Part1.add_lists([0,1,1], [1,1])
      [1,2]

  """
  @spec add_lists([integer()], [integer()]) :: [integer()]
  def add_lists([x | xs], [y | ys]) do
    [x + y | add_lists(xs, ys)]
  end

  def add_lists([], _ys), do: []
  def add_lists(_xs, []), do: []

  @doc ~S"""
  Infer the gamma value based on the given list of bit counts.

  ## Examples

      iex> Day03.Part1.gamma([7,4,1,0,3], 3)
      [1,1,0,0,1]

  """
  @spec gamma([integer()], integer()) :: [integer()]
  def gamma(bit_counts, threshold) do
    Enum.map(bit_counts, fn c -> if c >= threshold, do: 1, else: 0 end)
  end

  @doc ~S"""
  Compute the epsilon value from the gamma value and return both the gamma
  and the epsilon.

  ## Examples

      iex> Day03.Part1.epsilon_from_gamma([1,0,1,0,1])
      {[1,0,1,0,1], [0,1,0,1,0]}

  """
  @spec epsilon_from_gamma([integer()]) :: {[integer()], [integer()]}
  def epsilon_from_gamma(gamma) do
    {gamma, Enum.map(gamma, fn b -> rem(b + 1, 2) end)}
  end

  @spec bits_to_int([integer()]) :: integer()
  defp bits_to_int(bs) do
    Enum.reduce(bs, fn b, sum -> sum * 2 + b end)
  end

  @spec calc_answer({[integer()], [integer()]}) :: integer()
  def calc_answer({gamma, epsilon}) do
    bits_to_int(gamma) * bits_to_int(epsilon)
  end

  @spec solve([String.t()]) :: integer()
  defp solve(vals) do
    n = div(Enum.count(vals), 2)

    Enum.map(vals, &chars_to_ints/1)
    |> Enum.reduce(&add_lists/2)
    |> gamma(n)
    |> epsilon_from_gamma()
    |> calc_answer()
  end

  @spec main() :: :ok
  def main() do
    case File.read("res/day03.dat") do
      {:error, reason} ->
        IO.puts(:stderr, "Failed to read: #{reason}")

      {:ok, content} ->
        String.split(content) |> solve() |> IO.puts()
    end
  end
end

defmodule Day03.Part2 do
  @moduledoc "Solution to day 3 part 2."

  alias Day03.Part1

  @spec bit_masks([[integer()]]) :: {[integer()], [integer()]}
  defp bit_masks(vals) do
    n = div(Enum.count(vals), 2)
    Enum.reduce(vals, &Part1.add_lists/2) |> Part1.gamma(n) |> Part1.epsilon_from_gamma()
  end

  @spec mask_matches([integer()], [integer()], integer()) :: boolean()
  defp mask_matches(val, masks, idx) do
    Enum.at(val, idx) == Enum.at(masks, idx)
  end

  @spec apply_mask([[integer()]], [integer()]) :: [integer()]
  defp apply_mask([val | []], _mask) do
    val
  end

  defp apply_mask(vals, mask) do
  end

  @spec solve([String.t()]) :: integer()
  defp solve(vals) do
    inputs = Enum.map(vals, &Part1.chars_to_ints/1)
    {oxygen_mask, co2_mask} = bit_masks(inputs)
    oxygen = apply_mask(inputs, oxygen_mask)
    co2 = apply_mask(inputs, co2_mask)
    Part1.calc_answer({oxygen, co2})
  end

  @spec main() :: :ok
  def main() do
    case File.read("res/day03.dat") do
      {:error, reason} ->
        IO.puts(:stderr, "Failed to read: #{reason}")

      {:ok, content} ->
        String.split(content)
        |> solve()
        |> IO.puts()
    end
  end
end

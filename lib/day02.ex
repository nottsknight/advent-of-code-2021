defmodule Day02 do
  @typep location :: {integer(), integer()}
  @typep command :: {String.t(), integer()}

  @spec move(location(), command()) :: location()
  defp move({pos, depth}, {direction, distance}) do
    case direction do
      "forward" -> {pos + distance, depth}
      "up" -> {pos, depth + distance}
      "down" -> {pos, depth - distance}
    end
  end

  @spec makeMoves([command()], location()) :: location()
  defp makeMoves([cmd | cmds], loc) do
    makeMoves(cmds, move(loc, cmd))
  end

  defp makeMoves([], loc), do: loc

  @spec locMultiply(location()) :: integer()
  defp locMultiply({pos, depth}) do
    pos * depth
  end

  @spec main :: :ok
  def main do
    case File.read("res/day02.dat") do
      {:ok, content} ->
        String.split(content, ~r/\r|\n|\r\n|\n\r/)
        |> Enum.map(fn x -> String.split(x) end)
        |> Enum.map(fn [cmd | [dist | []]] -> {cmd, Integer.parse(dist)} end)
        |> Enum.map(fn {cmd, {dist, _}} -> {cmd, dist} end)
        |> makeMoves({0, 0})
        |> locMultiply()
        |> IO.puts()

      {:error, reason} ->
        IO.puts(:stderr, "Failed to read: #{reason}")
    end
  end
end

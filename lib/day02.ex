defmodule Day02 do
  # @typep location :: {integer(), integer()}
  @typep locationAim :: {integer(), integer(), integer()}
  @typep command :: {String.t(), integer()}

  @spec move(command(), locationAim()) :: locationAim()
  defp move({dir, dist}, {pos, depth, aim}) do
    case dir do
      "forward" -> {pos + dist, depth + (aim * dist), aim}
      "up" -> {pos, depth, aim - dist}
      "down" -> {pos, depth, aim + dist}
    end
  end

  @spec makeMoves([command()], locationAim()) :: locationAim()
  defp makeMoves([cmd | cmds], loc) do
    makeMoves(cmds, move(cmd, loc))
  end

  defp makeMoves([], loc), do: loc

  @spec parseCommand(String.t()) :: command()
  defp parseCommand(cmd) do
    [dir | [dist | _]] = String.split(cmd)
    {dist1, _} = Integer.parse(dist)
    {dir, dist1}
  end

  @spec locHash(locationAim()) :: integer()
  defp locHash({pos, depth, _}) do
    pos * depth
  end

  @spec main :: :ok
  def main do
    case File.read("res/day02.dat") do
      {:ok, content} ->
        String.split(content, ~r/\r|\n|\r\n|\n\r/)
        |> Enum.map(fn s -> parseCommand(s) end)
        |> makeMoves({0, 0, 0})
        |> locHash()
        |> IO.puts()

      {:error, reason} ->
        IO.puts("Failed to read: #{reason}")
    end
  end
end

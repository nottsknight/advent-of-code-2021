defmodule AOCUtils do
  @doc ~S"""
  Helper function to take the first element from a tuple.

      iex> fst {1, 2}
      1
  """
  @spec fst({t1, any()}) :: t1 when t1: var
  def fst({x, _y}), do: x

  @doc ~S"""
  Helper function to take the second element from a tuple.

      iex> snd {1, 2}
      2
  """
  @spec snd({any(), t1}) :: t1 when t1: var
  def snd({_x, y}), do: y
end

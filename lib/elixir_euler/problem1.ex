defmodule ElixirEuler.Problem1 do

  @doc """
    Finds the sum of all the multiples of basis values below max value.
  """
  def run(basis, max) do
    Enum.reduce(1..(max - 1), 0, fn (x, acc) ->
      if is_multiple(basis, x), do: acc + x, else: acc
    end)
  end
  
  defp is_multiple(basis, x) do
    Enum.reduce(basis, false, fn (b, memo) -> memo || rem(x, b) == 0 end)
  end

end

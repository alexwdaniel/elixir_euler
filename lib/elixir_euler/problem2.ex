require Integer

defmodule ElixirEuler.Problem2 do

  @doc """
    Finds the sum of the even-valued terms whose values do not exceed max.
  """
  def run(max), do: run(max, 0, HashDict.new)
  def run(max, n, dict) do
    {val, sum, dict} = fib(n, 0, dict)
    if val < max, do: run(max, n + 1, dict), else: sum
  end

  @doc """
    Wrapper for fib function. Calculates nth fibonacci number and sum of even
    values. Excludes HashDict of memoized values in returned tuple.

    Returns '{fibonacci number, even sum}'.
  """
  def calc_fib(n) do
    Tuple.delete_at(fib(n, 0, HashDict.new), 2)
  end

  defp fib(0, 0, fibCache), do: {0, 0, fibCache}
  defp fib(1, 0, fibCache), do: {1, 0, fibCache}
  defp fib(2, 0, fibCache), do: {1, 0, fibCache}
  defp fib(n, sum, fibCache) do
    if HashDict.has_key?(fibCache, n) do
      {val, esum} = HashDict.get(fibCache, n)
      {val, esum, fibCache}
    else
      {lhs, lsum, fibCache} = fib(n - 1, sum, fibCache)
      {rhs, _, fibCache} = fib(n - 2, sum, fibCache)

      val = lhs + rhs
      esum = even_sum(val, lsum)
      {val, esum, HashDict.put(fibCache, n, {val, esum})}
    end
  end

  defp even_sum(val, sum) do
    if Integer.is_even(val), do: sum + val, else: sum
  end

end

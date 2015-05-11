defmodule ElixirEuler.Problem4 do
  @moduledoc """
    Finds the largest palindrome made from the product of two 3-digit numbers by
    enumerating all possible products. Obvious improvements: eliminate repetitive
    multiplications, reduce search space.
  """

  @doc """
    Returns '{time, result}' of synchronous run.
  """
  def timed_run do
    :timer.tc(&run/0)
  end

  @doc """
    Returns '{time, result}' of asynchronous run.
  """
  def timed_async_run do
    :timer.tc(&async_run/0)
  end

  @doc """
    Synchronously enumerates all 3-digit products.
  """
  def run do
    calc_range(100..999)
  end

  @doc """
    Splits 100..999 range 2^x. Spawns processes to calculate subset of products.
  """
  def async_run do
    ranges = split_range(100, 999, 4)
    Enum.map(ranges, fn range -> spawn_run(self, range) end)
    ranges |> length |> receive_result([])
  end

  defp spawn_run(pid, range) do
    spawn __MODULE__, :send_run, [pid, range]
  end

  def send_run(pid, range) do
    send pid, calc_range(range)
  end

  defp receive_result(index, list) do
    receive do
      result ->
        results = List.flatten [result | list]
        if index == 1, do: Enum.max(results), else: receive_result(index - 1, results)
    end
  end

  defp calc_range(range) do
    range |> Enum.map(fn i -> calc(i, 100..999) end) |> List.flatten |> Enum.max
  end

  defp calc(n, range) do
    # :timer.sleep(50) # uncomment to produce parallel speedup
    range |> Enum.map(fn r -> n * r end) |> Enum.filter(&is_palindrome/1)
  end

  defp is_palindrome(n) do
    str = to_string(n)
    str == String.reverse(str)
  end

  defp split_range(first, last, 0), do: [Range.new(first, last)]
  defp split_range(first, last, pow) do
    mid = first + div(last - first, 2)
    split_range(first, mid, pow - 1) ++ split_range(mid + 1, last, pow - 1)
  end

end

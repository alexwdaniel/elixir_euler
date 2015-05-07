defmodule ElixirEuler.Problem3 do

  @doc """
    Finds the largest prime factor of N.
  """
  def run(n) do
    factors(n) |> Enum.sort(&(&1 > &2)) |> hd
  end

  @doc """
    Given N = p∗q, finds factor p using Pollard's rho algorithm, recursing on q
    until finding largest prime factor.
  """
  def factors(n, factorList \\ []) do
    p = factor(n)
    q = n / p
    if q == 1, do: [p | factorList], else: q |> round |> factors([p | factorList])
  end

  @doc """
    Finds factors of N using Floyd's cycle-finding algorithm. Pick k numbers
    x1,...,xk uniformly at random between 2 and N−1. If GCD(xi−xj,N) > 1, then
    GCD(xi−xj,N) is a factor of N.
  """
  def factor(a \\ 2, b \\ 2, n) do
    a1 = pseudo_rand(a,n)
    b1 = pseudo_rand(b,n) |> pseudo_rand(n)
    p = :erlang.abs(b1 - a1) |> round |> gcd(n)
    if p > 1, do: p, else: factor(a1, b1, n)
  end

  defp pseudo_rand(x,n) do
    (:math.pow(x, 2) + 1) |> round |> rem(n)
  end

  defp gcd(0, b), do: b
  defp gcd(a, 0), do: a
  defp gcd(a, b), do: gcd(b, rem(a, b))

end

defmodule Problem2Test do
  use ExUnit.Case

  test "calculates fib of n and sum of even values" do
    assert {0,0} == ElixirEuler.Problem2.calc_fib(0)
    assert {1,0} == ElixirEuler.Problem2.calc_fib(1)
    assert {2,2} == ElixirEuler.Problem2.calc_fib(3)
    assert {3,2} == ElixirEuler.Problem2.calc_fib(4)
    assert {5,2} == ElixirEuler.Problem2.calc_fib(5)
    assert {34,44} == ElixirEuler.Problem2.calc_fib(9)
  end

  test "gives the correct answer" do
    assert 4613732 == ElixirEuler.Problem2.run(4_000_000)
  end

end

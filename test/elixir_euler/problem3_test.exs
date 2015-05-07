defmodule Problem3Test do
  use ExUnit.Case

  test "returns prime factors of example" do
    assert [29, 13, 5, 7] == ElixirEuler.Problem3.factors(13195)
  end

  test "gives the correct answer" do
    assert 6857 == ElixirEuler.Problem3.run(600851475143)
  end

end

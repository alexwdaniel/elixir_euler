defmodule Problem1Test do
  use ExUnit.Case

  test "calculates the example" do
    assert ElixirEuler.Problem1.run([3,5], 10) == 23
  end

  test "gives the correct answer" do
    assert ElixirEuler.Problem1.run([3,5], 1000) == 233168
  end
end

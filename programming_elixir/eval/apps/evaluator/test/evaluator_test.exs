defmodule EvaluatorTest do
  use ExUnit.Case
  doctest Evaluator

  test "the truth" do
    assert 1 + 1 == 2
  end
end

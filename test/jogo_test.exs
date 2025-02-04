defmodule JogoTest do
  use ExUnit.Case
  doctest Jogo

  test "greets the world" do
    assert Jogo.hello() == :world
  end
end

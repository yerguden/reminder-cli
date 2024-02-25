defmodule ReminderCliTest do
  use ExUnit.Case
  doctest ReminderCli

  test "greets the world" do
    assert ReminderCli.hello() == :world
  end
end

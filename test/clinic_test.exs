defmodule ClinicTest do
  use ExUnit.Case
  doctest Clinic

  test "greets the world" do
    assert Clinic.hello() == :world
  end
end

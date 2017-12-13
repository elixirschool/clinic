defmodule Clinic.HealthCheckTests do
  use ExUnit.Case

  alias Clinic.HealthCheck

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  test "request with HTTP 200 response", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert "GET" == conn.method
      assert "/ping" == conn.request_path
      Plug.Conn.resp(conn, 200, "pong")
    end)

    assert {:ok, "pong"} = HealthCheck.ping("http://localhost:#{bypass.port}/ping")
  end

  test "request with unexpected outage", %{bypass: bypass} do
    Bypass.down(bypass)

    assert {:error, :econnrefused} = HealthCheck.ping("http://localhost:#{bypass.port}")
  end
end

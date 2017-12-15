defmodule Clinic.Scheduler do
  use GenServer

  require Logger

  alias Clinic.HealthCheck

  def init(opts) do
    sites = Keyword.fetch!(opts, :sites)
    interval = Keyword.fetch!(opts, :interval)
    health_check = Keyword.get(opts, :health_check, HealthCheck)

    Process.send_after(self(), :check, interval)

    {:ok, {health_check, sites}}
  end

  def handle_info(:check, {health_check, sites}) do
    sites
    |> health_check.ping()
    |> Enum.each(&report/1)

    {:noreply, {health_check, sites}}
  end

  defp report({:ok, body}), do: Logger.info(body)

  defp report({:error, reason}) do
    reason
    |> to_string()
    |> Logger.error()
  end
end

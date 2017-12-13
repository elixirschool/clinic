defmodule Clinic.HealthCheck do
  def ping(urls) when is_list(urls), do: Enum.map(urls, &ping/1)

  def ping(url) do
    url
    |> HTTPoison.get()
    |> response()
  end

  def response({:ok, %{status_code: 200, body: body}}), do: {:ok, body}
  def response({:ok, %{status_code: status_code}}), do: {:error, "HTTP Status #{status_code}"}
  def response({:error, %{reason: reason}}), do: {:error, reason}
end

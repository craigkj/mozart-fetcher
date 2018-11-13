defmodule MozartFetcher.Component do
  alias MozartFetcher.{Component, Config, Envelope, LocalCache}

  @derive [Poison.Encoder]
  defstruct [:index, :id, :status, :envelope]

  def fetch(config = %Config{}) do
    process(config, get(config))
  end

  defp process(config, {:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    %Component{index: 0, id: config.id, status: 200, envelope: Envelope.build({:ok, body})}
  end

  defp process(_config, {:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  defp get(config) do
    LocalCache.get_or_store(config.endpoint, fn() -> HTTPClient.get(config.endpoint) end)
  end
end
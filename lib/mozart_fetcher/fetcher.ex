defmodule MozartFetcher.Fetcher do
  alias MozartFetcher.{Component}

  use ExMetrics

  def process([]) do
    ExMetrics.increment("error.empty_component_list")
    Stump.log(:error, %{message: "Error cannot process empty component list"})
    {:error}
  end

  def process(components) do
    ExMetrics.timeframe "function.timing.fetcher.process" do
      components
      |> Enum.map(&Task.async(fn -> Component.fetch(&1) end))
      |> Enum.map(&Task.await/1)
      |> decorate_response
      |> Poison.encode!()
    end
  end

  defp decorate_response(envelopes) do
    %{components: envelopes}
  end
end

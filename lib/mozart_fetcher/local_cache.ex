defmodule MozartFetcher.LocalCache do
  def get_or_store(id, f) do
    case Application.get_env(:mozart_fetcher, :environment) do
      :prod -> ConCache.get_or_store(:fetcher_cache, id, f)
      _ -> f.()
    end
  end
end

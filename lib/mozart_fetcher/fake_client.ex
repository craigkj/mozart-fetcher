defmodule MozartFetcher.FakeClient do
  def returning(:success) do
    {:ok, successful_response()}
  end

  def returning(:timeout) do
    {:error, %HTTPoison.Error{reason: :timeout}}
  end

  def returning(:down) do
    {:error, %HTTPoison.Error{reason: :econnrefused}}
  end

  defp successful_response() do
    %HTTPoison.Response{
      status_code: 200,
      headers: [],
      body: ~s({"head":[],"bodyInline":"<DIV id=\\"site-container\\">","bodyLast":[]})
    }
  end
end
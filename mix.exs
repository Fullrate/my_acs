defmodule MyAcs.Mixfile do
  use Mix.Project

  def project do
    [
      app: :my_acs,
      version: "0.1.3",
      elixir: "~> 1.13",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {MyAcs, []}
    ]
  end

  defp deps do
    [
      {:acs_ex, "~> 0.3.18"}
    ]
  end
end

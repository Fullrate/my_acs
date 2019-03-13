defmodule MyAcs.Mixfile do
  use Mix.Project

  def project do
    [app: :my_acs,
     version: "0.1.2",
     elixir: "~> 1.8",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :acs_ex],
     mod: {MyAcs, []}]
  end

  defp deps do
    [
      {:acs_ex, "~> 0.3.3"}
    ]
  end
end


defmodule MyAcs.Mixfile do
  use Mix.Project

  def project do
    [app: :my_acs,
     version: "0.1.0",
     elixir: "~> 1.3",
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
      {:acs_ex, git: "git@github.com:Fullrate/acs_ex.git"}
    ]
  end
end


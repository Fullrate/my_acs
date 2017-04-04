defmodule MyAcs do
  @moduledoc """

  This is the supervisor for acs_ex, and all the other
  application eventually needed to make something for
  the real world

  """

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    acs_port = Application.get_env(:fullrate_acs, :acs_port, 7547)

    children = [
      worker(ACS, [MyAcs.Session, acs_port, {127,0,0,1}, {0,0,0,0,0,0}], [] ),
    ]

    opts = [strategy: :one_for_one, name: MyAcs.Supervisor]
    Supervisor.start_link(children, opts)
  end
end


defmodule MyAcs do
  @moduledoc """

  This is the supervisor for acs_ex, and all the other
  application eventually needed to make something for
  the real world

  """

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    acs_port = Application.get_env(:acs_ex, :acs_port, 7548)

    children = [
      {ACS,
       {MyAcs.Session, acs_port: acs_port, acs_ip: {127, 0, 0, 1}, acs_ipv6: {0, 0, 0, 0, 0, 0}}}
    ]

    opts = [strategy: :one_for_one, name: MyAcs.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

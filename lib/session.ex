defmodule MyAcs.Session do

  require Logger
  import ACS.Session.Script.Vendor.Helpers

  @doc """

  This is where the session starter (Inform) comes
  into play. From here you have access to the specced
  methods, defined in ACS.Session.Script.Vendor.Helpers
  of acs_ex.

  """
  def session_start(session, _device_id, inform ) do

    Logger.debug("Session started")

    case extractParameterValue( inform.parameters, "InternetGatewayDevice.DeviceInfo.ProvisioningCode" ) do
      [] ->
        Logger.error("ProvisioningCode not found")
        :error
      ["ProvisionMePlease"] -> setParameterValues( session, [%{name: "InternetGatewayDevice.DeviceInfo.ProvisioningCode", type: "xsd:string", value: "provisioned"}] )
    end

  end

  defp extractParameterValue( inform_parameters, param ) do
    for p <- inform_parameters, p.name == param, do: p.value
  end

end

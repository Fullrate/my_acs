defmodule MyAcsTest do
  use ExUnit.Case
  doctest MyAcs

  import RequestSenders

  @spv_sample_response ~s|<SOAP-ENV:Envelope xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cwmp="urn:dslforum-org:cwmp-1-0" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
\t<SOAP-ENV:Header>
\t\t<cwmp:ID SOAP-ENV:mustUnderstand="1">~s</cwmp:ID>
\t</SOAP-ENV:Header>
\t<SOAP-ENV:Body>
\t\t<cwmp:SetParameterValuesResponse>
\t\t\t<Status>0</Status>
\t\t</cwmp:SetParameterValuesResponse>
\t</SOAP-ENV:Body>
</SOAP-ENV:Envelope>|

  test "single SetParameterValues" do
    {:ok,resp,cookie} = sendFile(fixture_path("informs/plain1"))
    assert resp.body == readFixture!(fixture_path("informs/plain1_response"))
    assert resp.status_code == 200
    {:ok,resp,cookie} = sendStr("",cookie) # This should cause a GetParameterValue request
    assert resp.status_code == 200

    # Parse the response received
    {pres,parsed}=CWMP.Protocol.Parser.parse(resp.body)
    assert pres == :ok

    # assert values are what we expect them to be.
    params=for p <- hd(parsed.entries).parameters, do: {p.name,p.value}
    params_map=Enum.into(params, %{})

    assert Map.has_key?(params_map,"InternetGatewayDevice.DeviceInfo.ProvisioningCode")
    assert params_map["InternetGatewayDevice.DeviceInfo.ProvisioningCode"] == "provisioned"

    # Send a Response to end it. Should return "", end session by sending "" back
    spv_response=to_string(:io_lib.format(@spv_sample_response,[parsed.header.id]))
    {:ok,resp,_} = sendStr(spv_response,cookie)
    assert resp.body == ""
    assert resp.status_code == 204
  end

  test "cytco1" do
    {:ok,resp,cookie} = sendFile(fixture_path("informs/plain2"))
    assert resp.body == "Plug.Parsers.ParseError raised"
    assert resp.status_code == 400


    {:ok,resp,cookie} = sendFile(fixture_path("informs/plain2_handfixed"))
    assert resp.body == readFixture!(fixture_path("informs/plain2_response"))
    assert resp.status_code == 200
    {:ok,resp,cookie} = sendStr("",cookie) # This should cause a GetParameterValue request
    assert resp.status_code == 204

  end

end

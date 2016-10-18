defmodule Fw.WifiSSDPServer do
  use GenEvent

  @service Application.get_env(:discovery, :service)
  @name Application.get_env(:discovery, :name)

  def add_wifi_handler do
    GenEvent.add_handler(Nerves.NetworkInterface.event_manager, __MODULE__, [])
  end

  def handle_event({:udhcpc, _sender, :bound, _config}, state) do
    # Have to wait becuase network isn't actually up when we get the bound event
    Process.send_after(self(), :setup_ssdp, 1000)
    {:ok, state}
  end
  def handle_event(_, state) do
    {:ok, state}
  end

  def handle_info(:setup_ssdp, state) do
    device = "uuid:" <> UUID.uuid1()
    Nerves.SSDPServer.publish(device, @service, %{
      name: @name
    })

    {:ok, state}
  end
end

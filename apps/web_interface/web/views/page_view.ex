defmodule WebInterface.PageView do
  use WebInterface.Web, :view

  defp relay_status(pin) do
    {:ok, relay} = Relays.RelaySupervisor.get_relay(pin)
    Relays.Relay.status(relay)
  end
end

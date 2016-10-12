defmodule WebInterface.PageView do
  use WebInterface.Web, :view
  @relay_supervisor Application.get_env(:fw, :relay_supervisor)
  @relay Application.get_env(:fw, :relay)

  defp relay_status(pin) do
    {:ok, relay} = @relay_supervisor.get_relay(pin)
    @relay.status(relay)
  end
end

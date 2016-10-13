defmodule WebInterface.PageController do
  use WebInterface.Web, :controller

  def set_relay(conn, %{"relay" => pin, "status" => status}) do
    {pin, ""} = Integer.parse(pin)

    Relays.RelaySupervisor.get_relay(pin)
    |> update_relay(conn, status)
    |> redirect(to: "/")
  end

  defp update_relay({:error, error}, conn, _) do
    put_flash(conn, :error, error)
  end
  defp update_relay({:ok, relay}, conn, "on") do
    Relays.Relay.on(relay)
    conn
  end
  defp update_relay({:ok, relay}, conn, "off") do
    Relays.Relay.off(relay)
    conn
  end

  def index(conn, _params) do
    render conn, "index.html", relays: Relays.RelaySupervisor.standard_pins
  end
end

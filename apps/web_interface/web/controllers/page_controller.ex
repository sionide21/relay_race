defmodule WebInterface.PageController do
  use WebInterface.Web, :controller
  @relay_supervisor Application.get_env(:fw, :relay_supervisor)
  @relay Application.get_env(:fw, :relay)

  def set_relay(conn, %{"relay" => pin, "status" => status}) do
    {pin, ""} = Integer.parse(pin)

    @relay_supervisor.get_relay(pin)
    |> update_relay(conn, status)
    |> redirect(to: "/")
  end

  defp update_relay({:error, error}, conn, _) do
    put_flash(conn, :error, error)
  end
  defp update_relay({:ok, relay}, conn, "on") do
    @relay.on(relay)
    conn
  end
  defp update_relay({:ok, relay}, conn, "off") do
    @relay.off(relay)
    conn
  end

  def index(conn, _params) do
    render conn, "index.html", relays: @relay_supervisor.standard_pins
  end
end

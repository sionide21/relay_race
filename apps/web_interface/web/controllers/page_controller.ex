defmodule WebInterface.PageController do
  use WebInterface.Web, :controller
  @relay_supervisor Application.get_env(:fw, :relay_supervisor)

  def index(conn, _params) do
    render conn, "index.html", relays: @relay_supervisor.standard_pins
  end
end

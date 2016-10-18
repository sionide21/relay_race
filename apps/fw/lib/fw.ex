defmodule Fw do
  use Application

  @wifi_settings Application.get_env(:wifi, :settings)

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(Task, [fn -> start_network end], restart: :transient),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fw.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_network do
    Fw.WifiSSDPServer.add_wifi_handler()
    Nerves.InterimWiFi.setup("wlan0", @wifi_settings)
  end
end

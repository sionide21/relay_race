defmodule FakeFw.Relay do
  # Stub out FW so we can work on the web ui on a laptop

  def status(relay) when relay < 3 do
    :on
  end
  def status(_relay) do
    :off
  end
end

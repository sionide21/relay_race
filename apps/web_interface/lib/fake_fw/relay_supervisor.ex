defmodule FakeFw.RelaySupervisor do
  # Stub out FW so we can work on the web ui on a laptop

  def standard_pins do
    [1, 2, 3, 4, 5]
  end

  def get_relay(pin) do
    {:ok, pin}
  end
end

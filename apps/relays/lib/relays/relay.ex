defmodule Relays.Relay do
  use GenServer
  @gpio Application.get_env(:relays, Gpio, Relays.FakeGpio)

  @doc """
  Start a relay process for a given pin.

  Pins a referenced by the `GPIO` number on the pinout in
  the README of this project.
  """
  def start_link(pin) do
    GenServer.start_link(__MODULE__, pin)
  end

  @doc """
  Turns on the relay for a given period of time. If no time is given,
  relay stays on indefinitely.

  If the relay is already on, and a time is given, turn it off after
  that aount of time.

  Time is given in milliseconds.
  """
  def on(relay, time \\ nil)
  def on(relay, nil) do
    send(relay, :on)
  end
  def on(relay, time) when time > 0 do
    send(relay, {:on, time})
  end

  @doc """
  Turns off the relay for a given period of time. If no time is given,
  relay stays on indefinitely.

  Time is given in milliseconds.
  """
  def off(relay) do
    send(relay, :off)
  end

  @doc """
  Returns the current status of the relay, either `:on` or `:off`.
  """
  def status(relay) do
    GenServer.call(relay, :status)
  end

  # Callbacks

  # On init, start the GPIO for this pin
  def init(pin) do
    {:ok, gpio} = @gpio.start_link(pin, :output)
    @gpio.write(gpio, 1)
    {:ok, gpio}
  end


  # Turn on the relay
  def handle_info(:on, gpio) do
    @gpio.write(gpio, 0)
    {:noreply, gpio}
  end

  # Turn on the relay for a specified amount of time (milliseconds)
  def handle_info({:on, ms}, gpio) do
    @gpio.write(gpio, 0)
    Process.send_after(self(), :off, ms)
    {:noreply, gpio}
  end

  # Turn off the relay
  def handle_info(:off, gpio) do
    @gpio.write(gpio, 1)
    {:noreply, gpio}
  end


  # Get the status of the relay
  def handle_call(:status, _from, gpio) do
    status = case @gpio.read(gpio) do
      1 -> :off
      0 -> :on
    end

    {:reply, status, gpio}
  end
end

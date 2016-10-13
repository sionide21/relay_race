defmodule Relays.FakeGpio do
  @moduledoc """
  A stub implementation of Gpio for when running on a host machine.

  This is the default. Refer to the readme to setup elixir_ale for your GPIOs
  """

  defmodule FakeGpioState do
    @moduledoc false
    defstruct status: 0, mode: :output
  end


  def start_link(_pin, mode) do
    Agent.start_link(fn -> %FakeGpioState{mode: mode} end)
  end

  def write(gpio, status) do
    Agent.update(gpio, fn state -> %{state | status: status} end)
  end

  def read(gpio) do
    Agent.get(gpio, fn %{status: status} -> status end)
  end
end

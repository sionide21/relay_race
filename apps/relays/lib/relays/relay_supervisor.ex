defmodule Relays.RelaySupervisor do
  use Supervisor

  @relay_pins Application.get_env(:relay, :pins)

  @doc """
  Start a supervisor for the given list of pins.

  If no pins are specified, default to `standard_pins`.
  """
  def start_link(pins \\ standard_pins) do
    Supervisor.start_link(__MODULE__, pins, name: __MODULE__)
  end

  @doc """
  Get the supervised relay for a given pin supervised by this module.

  If no relay is found, return an error tuple.

  ## Examples

      iex> RelaySupervisor.get_relay(5)
      {:ok, #PID<0.97.0>}

      iex> RelaySupervisor.get_relay(123)
      {:error, "No such relay"}

  """
  def get_relay(pin) do
    __MODULE__
    |> Supervisor.which_children
    |> Enum.find(fn {id, _, _, _} -> id == pin end)
    |> case do
      {_, relay, _, _} when is_pid(relay) -> {:ok, relay}
      _ -> {:error, "No such relay"}
    end
  end

  @doc """
  The list of standard relay pins for this project.

  They are set in `config/config.exs`
  """
  def standard_pins do
    @relay_pins
  end

  # Start all passed in relays
  def init(pins) do
    children = Enum.map(pins, fn pin ->
      worker(Relays.Relay, [pin], id: pin)
    end)

    supervise(children, strategy: :one_for_one)
  end
end

defmodule Discovery.CLI do
  @service "relay-race"

  def main(_args) do
    Nerves.SSDPClient.discover(%{target: @service})
    |> Enum.map(fn {_, node} -> node end)
    |> Enum.sort_by(fn %{name: name} -> name end)
    |> Enum.each(fn node ->
      IO.puts "#{node.name}\thttp://#{node.host}/"
    end)
  end
end

defmodule TestTask do
  def trip_fuel(mass, routes) do
    reversed = Enum.reverse(routes)
    calculate(mass, reversed, 0)
  end

  defp calculate(mass, [], acc), do: acc
  defp calculate(mass, [hd | tail], acc) do
    fuel_mass = fuel_for_maneuver(mass, hd, 0)
    calculate(mass + fuel_mass, tail, acc + fuel_mass)
  end

  defp fuel_for_maneuver(mass, [], acc), do: acc
  defp fuel_for_maneuver(mass, {type, gravity} = route, acc) do
    fuel_mass = formula(type, mass, gravity)

    if fuel_mass > 0 do
      fuel_for_maneuver(fuel_mass, route, fuel_mass + acc)
    else
      acc
    end
  end

  defp formula(:land, mass, gravity), do: trunc(mass * gravity * 0.033 - 42)
  defp formula(:launch, mass, gravity), do: trunc(mass * gravity * 0.042 - 33)
end

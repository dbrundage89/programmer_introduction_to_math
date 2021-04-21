defmodule Math.Polynomial do
  def product_excluding(points, xi) do
    points
    |> Enum.map(fn {x, _y} -> x end)
    |> Enum.reject(fn x -> x == xi end)
    |> Enum.reduce(fn _x -> 1 end, fn xj, acc ->
      fn x -> acc.(x) * (x - xj) / (xi - xj) end
    end)
  end

  def interpolate(points) do
    points
    |> Enum.reduce(fn _x -> 0 end, fn {xi, yi}, acc ->
      fn x ->
        acc.(x) +
          yi *
            product_excluding(points, xi).(x)
      end
    end)
  end
end

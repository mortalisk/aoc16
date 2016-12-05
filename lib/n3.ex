defmodule N3 do

  def is_triangle([a, b, c]), do: a + b > c and a + c > b and b + c > a

  def solve do
    "input3"
    |> File.stream!()
    |> Stream.map(&String.split/1)
    |> Stream.map(fn t -> Enum.map(t, &String.to_integer/1) end)
    |> Stream.filter(&is_triangle/1)
    |> Enum.count
    |> IO.puts
  end

  def solve2 do
    "input3"
    |> File.stream!()
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk(9)
    |> Stream.flat_map(fn [a1, b1, c1, a2, b2, c2, a3, b3, c3] -> [[a1, a2, a3], [b1, b2, b3], [c1, c2, c3]] end)
    |> Stream.filter(&is_triangle/1)
    |> Enum.count
    |> IO.puts
  end
end

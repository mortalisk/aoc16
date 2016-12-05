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
end

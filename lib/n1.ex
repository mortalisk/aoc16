defmodule N1 do
  def solve do
    File.read!("input")
    |> String.strip()
    |> String.split(", ")
    |> Enum.reduce({:n, 0},
        fn
          ("L" <> steps, {:n, total}) -> {:w, total - String.to_integer(steps)}
          ("L" <> steps, {:w, total}) -> {:s, total - String.to_integer(steps)}
          ("L" <> steps, {:s, total}) -> {:e, total + String.to_integer(steps)}
          ("L" <> steps, {:e, total}) -> {:n, total + String.to_integer(steps)}
          ("R" <> steps, {:n, total}) -> {:e, total + String.to_integer(steps)}
          ("R" <> steps, {:w, total}) -> {:n, total + String.to_integer(steps)}
          ("R" <> steps, {:s, total}) -> {:w, total - String.to_integer(steps)}
          ("R" <> steps, {:e, total}) -> {:s, total - String.to_integer(steps)}
        end)
    |> IO.inspect()
  end

  def turn("R" <> rest, {x, y}), do: {{y, -x}, String.to_integer(rest)}
  def turn("L" <> rest, {x, y}), do: {{-y, x}, String.to_integer(rest)}

  def move(cmd, {dir, pos, visited}) do
    {dir, n} = turn(cmd, dir)
    res = {_dir, p, vis} =
      1..n
      |> Enum.reduce_while({dir, pos, visited},
        fn(_i, {{xi, yi}, {x, y}, visited}) ->
          vis = MapSet.put(visited, {x, y})
          pos = {x + xi, y + yi}
          if (MapSet.member?(visited, pos)) do
            {:halt, {dir, pos, vis}}
          else
            {:cont, {dir, pos, vis}}
          end
        end)

    if (MapSet.member?(vis, p)) do
      {:halt, res}
    else
      {:cont, res}
    end
  end

  def solve2 do
    File.read!("input")
    |> String.strip()
    |> String.split(", ")
    |> Enum.reduce_while({{0, 1}, {0, 0}, MapSet.new([{0, 0}])}, &move/2)
    |> elem(1)
    |> (fn {x, y} -> abs(x) + abs(y) end).()
    |> IO.inspect()
  end
end

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
end

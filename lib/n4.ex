defmodule N4 do

  def check(letters, chk) do
    readchk =
      letters
      |> Enum.reduce(%{}, fn (char, map) ->
           Map.update(map, char, 1, &(&1 + 1))
         end)
      |> Enum.sort_by(fn {char, _} -> char end)
      |> Enum.sort_by(fn {_, count} -> count end, &>=/2)
      |> Enum.map(&(elem(&1, 0)))
      |> Enum.take(Enum.count(chk))

    readchk == chk
  end

  def list do
    "input4"
    |> File.stream!()
    |> Stream.map(&(String.split(&1, ["-", "[", "]"])))
    |> Stream.map(fn(line) ->
          letters = line |> Enum.drop(-3) |> Enum.flat_map(&to_charlist/1)
          id = line |> Enum.at(-3) |> String.to_integer()
          chk = line |> Enum.at(-2) |> String.to_charlist()
          { letters, id, chk }
        end)
    |> Stream.filter(fn {letters, _, chk} -> check(letters, chk) end)
  end

  def solve do
    list
    |> Stream.map(&(elem(&1,1)))
    |> Enum.sum()
    |> IO.puts()
  end

  def solve2 do
    list
    |> Stream.map(fn {letters, id, _} ->
      d = letters |> Enum.map(&(rem((&1 - 97) + id, 26) + 97))
      {d, id}
    end)
    |> Stream.filter(fn {str, _} -> str == 'northpoleobjectstorage' end)
    |> Enum.take(1)
    |> Enum.at(0)
    |> elem(1)
    |> IO.puts()
  end
end

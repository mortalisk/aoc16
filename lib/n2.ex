defmodule N2 do
  def solve do
    "input2"
    |> File.read!()
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.graphemes/1)
    |> Enum.reduce([5], fn(chars, d = [position | _]) ->
          new_pos = Enum.reduce(chars, position, fn(char, pos) ->
               cond do
                 char == "U" and not Enum.member?([1, 2, 3], pos) -> pos - 3
                 char == "L" and not Enum.member?([1, 4, 7], pos) -> pos - 1
                 char == "R" and not Enum.member?([3, 6, 9], pos) -> pos + 1
                 char == "D" and not Enum.member?([7, 8, 9], pos) -> pos + 3
                 true -> pos
               end
             end)
           [new_pos | d]
          end)
    |> Enum.reverse()
    |> Enum.drop(1)
    |> Enum.map(&to_string/1)
    |> Enum.join()
    |> IO.puts()
  end

  def movUp(3), do: 1
  def movUp(pos) when pos < 13, do: pos - 4
  def movUp(13), do: 11

  def movDn(11), do: 13
  def movDn(pos) when pos > 1, do: pos + 4
  def movDn(1), do: 3

  def move(char, pos) do
    cond do
      char == "U" and not Enum.member?([1,  2,  4,  5,  9], pos) -> movUp(pos)
      char == "L" and not Enum.member?([1,  2,  5, 10, 13], pos) -> pos - 1
      char == "R" and not Enum.member?([1,  4,  9, 12, 13], pos) -> pos + 1
      char == "D" and not Enum.member?([5, 10, 13, 12,  9], pos) -> movDn(pos)
      true -> pos
    end
  end

  def solve2 do
    "input2"
    |> File.read!()
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.graphemes/1)
    |> Enum.reduce([5], fn(chars, d = [position | _]) ->
            new_pos = Enum.reduce(chars, position, &move/2)
            [new_pos | d]
          end)
    |> Enum.reverse()
    |> Enum.drop(1)
    |> Enum.map(&(Integer.to_string(&1, 16)))
    |> Enum.join()
    |> IO.puts()
  end
end

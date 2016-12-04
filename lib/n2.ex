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
  end
end

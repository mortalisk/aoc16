defmodule N6 do

  def decrypt(comp, startval) do
    freq=
      "input6"
      |> File.stream!()
      |> Stream.map(&String.graphemes/1)
      |> Stream.map(&Enum.with_index/1)
      |> Enum.reduce(%{}, fn(str, map) ->
           Enum.reduce(str, map, fn({char, i}, map) ->
             Map.update(map, i, %{char => 1}, fn(charmap) -> Map.update(charmap, char, 1, &(&1 + 1)) end)
           end)
         end)
    n = Enum.count(freq) - 1
    IO.inspect(freq)

    0..n
    |> Enum.reduce([], fn(i, acc) ->
          char =
            Enum.reduce(freq[i], {?z, startval}, fn({c, n}, {smallc, smalln}) ->
              if comp.(n, smalln) do
                {c, n}
              else
                {smallc, smalln}
              end
            end)
            |> elem(0)
          [char | acc]
      end)
    |>Enum.reverse()
    |>IO.puts()
  end

  def solve, do: decrypt(&(&1 > &2), 0)

  def solve2, do: decrypt(&(&1 < &2), 10000)


end

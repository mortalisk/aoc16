defmodule N5 do
  @id "reyedfim"

  def md5 index do
    str = @id <> Integer.to_string(index)
    Base.encode16(:crypto.hash(:md5, str), case: :lower)
  end

  def solve do
    Stream.iterate(0, &(&1+1))
    |> Stream.map(&md5/1)
    |> Stream.filter(&(String.starts_with?(&1, "00000")))
    |> Enum.take(8)
    |> Enum.map(fn("00000" <> rest) -> String.at(rest, 0) end)
    |> Enum.to_list()
    |> to_string()
    |> IO.inspect()
  end

  def solve2 do
    Stream.iterate(0, &(&1+1))
    |> Stream.map(&md5/1)
    |> Stream.filter(&(String.starts_with?(&1, "00000")))
    |> Stream.map(fn(hash) ->
            i = hash
                |> String.at(5)
                |> Integer.parse()
             case i do
               :error -> :error
               {i, _} -> {i, String.at(hash, 6)}
             end
          end)
    |> Stream.filter(fn
            (:error) -> false
            (_) -> true
          end)
    |> Enum.take(8)
    |> Enum.sort_by(&(elem(&1, 0)))
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.to_list()
    |> to_string()
    |> IO.inspect()
  end

end

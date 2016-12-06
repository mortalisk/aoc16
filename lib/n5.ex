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

end

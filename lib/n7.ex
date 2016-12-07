defmodule N7 do
  @hasabba ~r/(.)(.)(\2(?!\2))(\1)/
  @abbainhyper ~r/\[[a-z]*(.)(.)(\2(?!\2))(\1)[a-z]*\]/
  @hyper ~r/\[.*\]/r
  def solve do
    "input7"
    |> File.stream!()
    |> Stream.reject(&(Regex.match?(@abbainhyper, &1)))
    |> Stream.map(&(Regex.replace(@hyper, &1, "\-")))
    |> Stream.filter(&(Regex.match?(@hasabba, &1)))
    |> Enum.count()
    |> IO.puts()
  end

  #@aba ~r/\[[a-z]*(.)(?!\1)(.)(\1)[a-z]*\]/
  @abastart ~r/([a-z])(?!\1)(?=[a-z]\1)/

  def solve2 do
    "input7"
    |> File.stream!()
    |> Stream.filter(
        fn (line) ->
          linewithouthypers = Regex.replace(@hyper, line, "\-")
          abas =
            Regex.scan(@abastart, linewithouthypers, return: :index)
            |> Enum.map(
                fn [{i, 1}, {i, 1}] ->
                  String.slice(linewithouthypers, i, 2)
                  |> String.graphemes()
                end)
          hypers =
            Regex.scan(@hyper, line)
            |> Enum.map(fn [hyper] -> hyper end)
          n = abas
            |> Enum.filter(
                fn([a, b]) ->
                  Enum.find(hypers, &(String.contains?(&1, b <> a <> b))) != nil
                end)
            |> Enum.count()
          n > 0

        end)
    |> Enum.count()
    |> IO.puts()
  end

end

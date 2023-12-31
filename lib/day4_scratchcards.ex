defmodule Day4Scratchcards do
  def part1(input_file) do
    Day1Trebuchet.parse_input(input_file)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&get_card_points/1)
    |> Enum.sum()
  end

  def parse_line(line) do
    line
    |> String.replace(~r/Card\s+\d+:\s/, "")
    |> String.split("|")
    |> Enum.map(&Regex.scan(~r/\d+/, &1))
  end

  def get_card_points([winners, owned]) do
    for w <- winners, o <- owned, w == o, reduce: 0 do
      acc -> if(acc == 0, do: acc + 1, else: acc * 2)
    end
  end
end

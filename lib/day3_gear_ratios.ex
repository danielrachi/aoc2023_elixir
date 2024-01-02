defmodule Day3GearRatios do
  @moduledoc """
    After failing to solve this tiwce (look at the .bak files), I found a very nice
    solution [in the forum](https://elixirforum.com/t/advent-of-code-2023-day-3/60113?u=danielrachi]
  """

  def part1(input_file) do
    lines =
      Day1Trebuchet.parse_input(input_file)
      |> Enum.with_index()

    nums = get_nums(lines)
    symbol_positions = get_symbol_positions(lines)

    nums
    |> Stream.filter(fn {row_span, col_span, _n} ->
      for i <- row_span,
          j <- col_span,
          reduce: false,
          do: (acc -> acc || {i, j} in symbol_positions)
    end)
    |> Stream.map(&elem(&1, 2))
    |> Enum.sum()
  end

  def part2(input_file) do
    lines =
      Day1Trebuchet.parse_input(input_file)
      |> Enum.with_index()

    nums = get_nums(lines)

    lines
    |> Stream.flat_map(fn {line, i} ->
      Regex.scan(~r/\*/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, _} -> {i, j} end)
    end)
    |> Stream.map(fn {i, j} ->
      case Enum.filter(nums, fn {row_span, col_span, _n} -> i in row_span and j in col_span end) do
        [a, b] -> elem(a, 2) * elem(b, 2)
        _ -> 0
      end
    end)
    |> Enum.sum()
  end

  def get_nums(lines) do
    lines
    |> Enum.flat_map(fn {line, i} ->
      Regex.scan(~r/\d+/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, len} ->
        {(i - 1)..(i + 1)//1, (j - 1)..(j + len)//1,
         String.to_integer(String.slice(line, j, len))}
      end)
    end)
  end

  def get_symbol_positions(lines) do
    lines
    |> Stream.flat_map(fn {line, i} ->
      Regex.scan(~r/[^a-zA-z0-9\.]/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, _} -> {i, j} end)
    end)
    |> MapSet.new()
  end
end

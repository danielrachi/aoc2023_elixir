defmodule Day1Trebuchet do
  @moduledoc """
  Solution for Day 1's problem of AOC 2023.

  After my very ugly first solution, this one is inspired by [this one](https://elixirforum.com/t/advent-of-code-2023-day-1/60073/2?u=danielrachi) I found on the elixir forum.
  """

  @doc """
  Parse file path into list with each line being an element.
  """
  def parse_input(path) do
    {:ok, input} = File.read(path)
    String.split(input, "\n", trim: true)
  end

  @doc """
  Get the number from one entry.
  """
  def get_entry_number(entry) do
    all_numbers = Enum.filter(entry, fn char -> char in ?0..?9 end)
    first_number = hd(all_numbers)
    last_number = hd(Enum.reverse(all_numbers))
    List.to_integer([first_number, last_number])
  end

  @doc """
  Replace spelt numbers like "one" for actual numbers like "1"
  """
  def replace_spelt_numbers("one" <> rest), do: "1" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("two" <> rest), do: "2" <> replace_spelt_numbers("o" <> rest)
  def replace_spelt_numbers("three" <> rest), do: "3" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("four" <> rest), do: "4" <> replace_spelt_numbers("r" <> rest)
  def replace_spelt_numbers("five" <> rest), do: "5" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("six" <> rest), do: "6" <> replace_spelt_numbers("x" <> rest)
  def replace_spelt_numbers("seven" <> rest), do: "7" <> replace_spelt_numbers("n" <> rest)
  def replace_spelt_numbers("eight" <> rest), do: "8" <> replace_spelt_numbers("t" <> rest)
  def replace_spelt_numbers("nine" <> rest), do: "9" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers(<<char, rest::binary>>), do: <<char>> <> replace_spelt_numbers(rest)
  def replace_spelt_numbers(""), do: ""

  def part1(file) do
    parse_input(file)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&get_entry_number/1)
    |> Enum.sum()
  end

  def part2(file) do
    parse_input(file)
    |> Enum.map(&replace_spelt_numbers/1)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&get_entry_number/1)
    |> Enum.sum()
  end
end

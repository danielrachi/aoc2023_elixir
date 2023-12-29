defmodule Day2CubeConundrum do
  @bag_contents %{
    red: 12,
    green: 13,
    blue: 14
  }

  def part1(input_file_path) do
    Day1Trebuchet.parse_input(input_file_path)
    |> Enum.map(&parse_game/1)
    |> Enum.map(&process_game_part_1/1)
    |> Enum.sum()
  end

  def part2(input_file_path) do
    Day1Trebuchet.parse_input(input_file_path)
    |> Enum.map(&parse_game/1)
    |> Enum.map(&process_game_part_2/1)
    |> Enum.sum()
  end

  def parse_game(game) do
    [game_id_full, sets_full] = String.split(game, ":", trim: true)
    game_id = 
      game_id_full
      |> String.split(" ", trim: true)
      |> List.last()
      |> Integer.parse()
      |> elem(0)
    sets = 
      sets_full
      |> String.split(";", trim: true)
      |> Enum.map(&String.split(&1, ",", trim: true))
      |> Enum.map(
      fn inner_list -> 
        Enum.map(inner_list, fn element -> 
          [number_str, color_str] = String.split(element, " ", trim: true)
          [String.to_integer(number_str), String.to_atom(color_str)]
        end)
      end)
    [game_id, sets]
  end

  def process_game_part_1(parsed_game) do
    [game_id, sets] = parsed_game
    if valid_sets?(sets) do
      game_id
    else
      0
    end
  end

  def valid_sets?(sets) do
    Enum.all?(sets, fn set -> 
      Enum.all?(set, fn [number, color] -> 
        case color do
         :red -> number <= Map.get(@bag_contents, :red)
         :green -> number <= Map.get(@bag_contents, :green)
         :blue -> number <= Map.get(@bag_contents, :blue)
        end
      end)
    end)
  end

  def process_game_part_2(parsed_game) do
    [_, sets] = parsed_game

    {minimun_red, minimun_green, minimun_blue} =
      Enum.reduce(sets, {0, 0, 0}, fn set, {red, green, blue} ->
        Enum.reduce(set, {red, green, blue}, fn [number, color], {acc_red, acc_green, acc_blue} ->
          case color do
            :red -> {max(acc_red, number), acc_green, acc_blue}
            :green -> {acc_red, max(acc_green, number), acc_blue}
            :blue -> {acc_red, acc_green, max(acc_blue, number)}
          end
        end)
      end)

    minimun_red * minimun_green * minimun_blue
  end
end

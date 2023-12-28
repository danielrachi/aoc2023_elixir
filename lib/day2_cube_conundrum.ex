defmodule Day2CubeConundrum do
  @bag_contents %{
    red: 12,
    green: 13,
    blue: 14
  }

  def part1(input_file_path) do
    Day1Trebuchet.parse_input(input_file_path)
    |> Enum.map(&parse_game/1)
    |> Enum.map(&process_game/1)
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

  def process_game(parsed_game) do
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
end

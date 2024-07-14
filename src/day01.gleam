import gleam/int
import gleam/io
import gleam/string
import simplifile

fn get_floor(char move, int floor) {
  case move {
    "(" -> floor + 1
    ")" -> floor - 1
    _ -> panic
  }
}

fn move_floor(list moves, int floor) {
  case moves {
    [m, ..rest] -> move_floor(rest, get_floor(m, floor))
    _ -> floor
  }
}

fn solve_part1(file_path) {
  let assert Ok(contents) = simplifile.read(file_path)
  contents
  |> string.split("")
  |> move_floor(0)
}

pub fn solve() {
  solve_part1("data/day01.txt")
  |> int.to_string()
  |> fn(result) { io.println("Part1: " <> result) }
}

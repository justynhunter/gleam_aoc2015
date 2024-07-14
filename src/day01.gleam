import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

fn solve_part1(file_path) {
  let assert Ok(contents) = simplifile.read(file_path)
  let ups =
    contents
    |> string.split("")
    |> list.filter(fn(c) { c == "(" })
    |> list.length

  ups - { list.length(string.split(contents, "")) - ups }
}

fn run_steps(string step, int curr_floor, index index) {
  case step {
    ["(", ..rest] -> run_steps(rest, curr_floor + 1, index + 1)
    [")", ..rest] ->
      case curr_floor {
        0 -> index
        _ -> run_steps(rest, curr_floor - 1, index + 1)
      }
    _ -> panic
  }
}

fn solve_part2(file_path) {
  let assert Ok(contents) = simplifile.read(file_path)
  contents |> string.split("") |> run_steps(0, 1)
}

pub fn solve() {
  solve_part1("data/day01.txt")
  |> int.to_string()
  |> fn(result) { io.println("Part1: " <> result) }

  solve_part2("data/day01.txt")
  |> int.to_string()
  |> fn(result) { io.println("Part2: " <> result) }
}

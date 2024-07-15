import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn solve() {
  let assert Ok(contents) = simplifile.read("data/day03.txt")
  contents
  |> string.split("")
  |> solve_part1()
  |> int.to_string()
  |> fn(result) { io.println("Part1: " <> result) }
}

fn solve_part1(instructions) {
  count_houses(instructions, [], #(0, 0))
}

fn count_houses(dirs, history, curr: #(Int, Int)) {
  case dirs {
    [] -> list.length(history)
    [dir, ..rest] -> {
      let new_loc = case dir {
        "<" -> #(curr.0 - 1, curr.1)
        ">" -> #(curr.0 + 1, curr.1)
        "v" -> #(curr.0, curr.1 - 1)
        "^" -> #(curr.0, curr.1 + 1)
        _ -> panic
      }

      case list.contains(history, new_loc) {
        True -> count_houses(rest, history, new_loc)
        False -> count_houses(rest, [new_loc, ..history], new_loc)
      }
    }
  }
}

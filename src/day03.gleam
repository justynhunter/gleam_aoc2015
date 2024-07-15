import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

type Location =
  #(Int, Int)

pub fn solve() {
  let assert Ok(contents) = simplifile.read("data/day03.txt")
  contents
  |> string.split("")
  |> solve_part1()
  |> int.to_string()
  |> fn(result) { io.println("Part1: " <> result) }

  contents
  |> string.split("")
  |> solve_part2()
  |> int.to_string()
  |> fn(result) { io.println("Part2: " <> result) }
}

fn solve_part1(instructions) {
  count_houses(instructions, [], #(0, 0))
}

fn solve_part2(instruction) {
  count_houses_robo(instruction, [], Santa, #(#(0, 0), #(0, 0)))
}

type Turn {
  Santa
  RoboSanta
}

fn count_houses_robo(dirs, history, turn, locs: #(Location, Location)) {
  let curr = case turn {
    Santa -> locs.0
    RoboSanta -> locs.1
  }

  case dirs {
    [] -> list.length(history)
    [dir, ..rest] -> {
      let new_loc = do_move(dir, curr)
      case list.contains(history, new_loc) {
        True ->
          count_houses_robo(
            rest,
            history,
            { switch_turn(turn) },
            update_curr_loc(locs, new_loc, turn),
          )
        False ->
          count_houses_robo(
            rest,
            [new_loc, ..history],
            { switch_turn(turn) },
            update_curr_loc(locs, new_loc, turn),
          )
      }
    }
  }
}

fn do_move(dir, loc: Location) {
  case dir {
    "<" -> #(loc.0 - 1, loc.1)
    ">" -> #(loc.0 + 1, loc.1)
    "v" -> #(loc.0, loc.1 - 1)
    "^" -> #(loc.0, loc.1 + 1)
    _ -> panic
  }
}

fn update_curr_loc(locs: #(Location, Location), new_loc, turn) {
  case turn {
    Santa -> #(new_loc, locs.1)
    RoboSanta -> #(locs.0, new_loc)
  }
}

fn switch_turn(turn) {
  case turn {
    Santa -> RoboSanta
    RoboSanta -> Santa
  }
}

fn count_houses(dirs, history, curr: Location) {
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

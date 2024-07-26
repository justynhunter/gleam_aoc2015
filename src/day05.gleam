import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn solve() {
  let assert Ok(contents) = simplifile.read("data/day05.txt")

  let lines = string.split(contents, "\n")

  lines
  |> solve_part1()
  |> int.to_string
  |> fn(result) { io.println("Part1: " <> result) }

  lines
  |> solve_part2()
  |> int.to_string
  |> fn(result) { io.println("Part2: " <> result) }
}

fn solve_part1(lines) {
  lines
  |> list.filter(has_three_vowels)
  |> list.filter(has_double)
  |> list.filter(has_no_bad_string)
  |> list.length
}

fn has_three_vowels(s) {
  let vowels = ["a", "e", "i", "o", "u"]

  string.split(s, "")
  |> list.count(fn(c) { list.contains(vowels, c) })
  |> fn(cnt) {
    case cnt {
      c if c > 2 -> True
      _ -> False
    }
  }
}

fn has_double(s) {
  string.split(s, "")
  |> list.window(2)
  |> list.any(fn(pair) {
    case pair {
      [x, y] if x == y -> True
      _ -> False
    }
  })
}

fn has_no_bad_string(s) {
  let bad_strings = ["ab", "cd", "pq", "xy"]

  string.split(s, "")
  |> list.window(2)
  |> list.any(fn(pair) {
    string.join(pair, "")
    |> list.contains(bad_strings, _)
  })
  |> fn(b) {
    case b {
      True -> False
      _ -> True
    }
  }
}

fn solve_part2(lines) {
  lines
  |> list.filter(has_double_pairs)
  |> list.filter(has_split_double)
  |> list.length
}

fn has_double_pairs(s) {
  string.split(s, "")
  |> list.window_by_2

  True
}

fn has_split_double(s) {
  string.split(s, "")
  |> list.window(3)
  |> list.any(fn(l) {
    case l {
      [x, _, z] if x == z -> True
      _ -> False
    }
  })
}

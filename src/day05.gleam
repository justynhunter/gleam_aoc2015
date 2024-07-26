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
  // count by letters
  |> list.fold([], fn(acc: List(#(#(String, String), Int)), i) {
    case acc {
      // adds item to acc if its empty
      [] -> [#(i, 1)]
      _ -> {
        case list.any(acc, fn(a) { a.0 == i }) {
          // add pair to acc if it isn't there already
          False -> [#(i, 1), ..acc]
          // update count if it does
          True -> {
            let assert Ok(item_to_replace) =
              list.find(acc, fn(item) { i == item.0 })

            [
              #(item_to_replace.0, item_to_replace.1 + 1),
              ..list.filter(acc, fn(item) { i != item.0 })
            ]
          }
        }
      }
    }
  })
  // get ones with a count > 0
  |> list.filter(fn(t) { t.1 > 1 })
  // just get the pair
  |> list.map(fn(t) { t.0 })
  // check that the pair exists two distinct times
  |> list.any(fn(t) {
    string.length(s) - { string.replace(s, t.0 <> t.1, "") |> string.length }
    >= 4
  })
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

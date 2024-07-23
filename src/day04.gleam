import gleam/bit_array
import gleam/crypto
import gleam/int
import gleam/io

pub fn solve() {
  test_hash(part1_checker, "ckczppom", 0)
  |> int.to_string
  |> fn(result) { io.println("Part 1: " <> result) }

  test_hash(part2_checker, "ckczppom", 0)
  |> int.to_string
  |> fn(result) { io.println("Part 2: " <> result) }
}

fn part1_checker(hash) {
  case hash {
    <<0x0, 0x0, hex, _:bits>> if hex <= 0x0f -> True
    _ -> False
  }
}

fn part2_checker(hash) {
  case hash {
    <<0x0, 0x0, 0x0, _:bits>> -> True
    _ -> False
  }
}

fn test_hash(checker, secret, num) {
  bit_array.from_string(secret <> int.to_string(num))
  |> crypto.hash(crypto.Md5, _)
  |> checker
  |> fn(is_ok) {
    case is_ok {
      True -> num
      False -> test_hash(checker, secret, num + 1)
    }
  }
}

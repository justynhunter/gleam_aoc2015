import gleam/bit_array
import gleam/crypto
import gleam/int
import gleam/io

pub fn solve() {
  solve_part1("ckczppom")
  |> int.to_string
  |> fn(result) { io.println("Part1: " <> result) }
}

fn solve_part1(secret) {
  test_hash(secret, 0)
}

fn test_hash(string secret, int num) {
  let hash = hash(secret <> int.to_string(num))
  case hash {
    <<0x0, 0x0, hex, _:bits>> if hex <= 0x0f -> num
    _ -> test_hash(secret, num + 1)
  }
}

fn hash(text) {
  bit_array.from_string(text)
  |> crypto.hash(crypto.Md5, _)
}

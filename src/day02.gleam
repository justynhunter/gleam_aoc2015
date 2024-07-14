import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile
import util

pub fn solve() {
  let assert Ok(contents) = simplifile.read("data/day02.txt")

  contents
  |> string.split("\n")
  |> solve_part1()
  |> int.to_string()
  |> fn(result) { io.println("Part1: " <> result) }

  contents
  |> string.split("\n")
  |> solve_part2()
  |> int.to_string()
  |> fn(result) { io.println("Part2: " <> result) }
}

fn solve_part1(lines) {
  lines
  |> list.map(parse_dims)
  |> list.map(required_wrap)
  |> util.sum
}

fn solve_part2(lines) {
  lines
  |> list.map(parse_dims)
  |> list.map(ribbon_len)
  |> util.sum
}

fn parse_dims(line) {
  case string.split(line, "x") {
    [ws, hs, ls] -> {
      let assert Ok(w) = int.parse(ws)
      let assert Ok(h) = int.parse(hs)
      let assert Ok(l) = int.parse(ls)
      #(w, h, l)
    }
    _ -> panic
  }
}

fn required_wrap(dims) {
  let #(w, h, l) = dims
  let wh = w * h
  let wl = w * l
  let hl = h * l
  let extra = int.min(wh, wl) |> int.min(hl)
  { 2 * wh } + { 2 * wl } + { 2 * hl } + extra
}

fn ribbon_len(dims) {
  let #(w, h, l) = dims
  let ribbon = h * w * l
  let extra = int.min(w + h, w + l) |> int.min(h + l)

  ribbon + { 2 * extra }
}

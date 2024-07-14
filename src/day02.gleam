import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn solve() {
  let assert Ok(contents) = simplifile.read("data/day02.txt")

  contents
  |> string.split("\n")
  |> solve_part1()
  |> int.to_string()
  |> fn(result) { io.println("Part1: " <> result) }
}

fn solve_part1(lines) {
  lines
  |> list.map(parse_dims)
  |> list.map(required_wrap)
  |> list.fold(0, fn(acc, i) { acc + i })
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

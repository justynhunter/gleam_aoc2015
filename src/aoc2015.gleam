import argv
import day01
import gleam/int
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["day", day] -> run_day(day)
    _ -> io.println("usage: ./aoc2015 day <number>")
  }
}

fn run_day(string day) {
  let assert Ok(day_i) = int.parse(day)
  case day_i {
    1 -> day01.solve()
    _ -> io.println("day " <> day <> " not done yet")
  }
}

import gleam/io
import gleam/list

pub fn sum(lst) {
  list.fold(lst, 0, fn(acc, i) { acc + i })
}

// print out value of t then return it for debugging
pub fn dbg(t) {
  io.debug(t)
  t
}

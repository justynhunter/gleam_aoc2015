import gleam/list

pub fn sum(lst) {
  list.fold(lst, 0, fn(acc, i) { acc + i })
}

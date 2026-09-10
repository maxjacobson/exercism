import gleam/list
import gleam/result

pub fn today(days: List(Int)) -> Int {
  list.first(days) |> result.unwrap(0)
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [first, ..rest] -> [first + 1, ..rest]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  list.any(days, fn(day) { day == 0 })
}

pub fn total(days: List(Int)) -> Int {
  list.fold(over: days, from: 0, with: fn(acc, day) { acc + day })
}

pub fn busy_days(days: List(Int)) -> Int {
  list.count(days, fn(day) { day >= 5 })
}

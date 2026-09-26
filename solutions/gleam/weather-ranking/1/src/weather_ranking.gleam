import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

// To convert Fahrenheit to Celsius subtract 32 from the Fahrenheit value, and then divide the result by 1.8.
pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

fn temperature_to_celsius(t: Temperature) -> Float {
  case t {
    Celsius(f) -> f
    Fahrenheit(f) -> fahrenheit_to_celsius(f)
  }
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case temperature_to_celsius(left), temperature_to_celsius(right) {
    x, y if x >. y -> order.Gt
    x, y if x <. y -> order.Lt
    _, _ -> order.Eq
  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, by: fn(left, right) {
    compare_temperature(left.temperature, right.temperature)
  })
}

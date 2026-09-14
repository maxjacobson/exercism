import gleam/list

// TODO: please define the Pizza custom type
pub type Pizza {
  Margherita
  Formaggio
  Caprese
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_price_helper(pizza, 0)
}

fn pizza_price_helper(pizza: Pizza, acc: Int) -> Int {
  case pizza {
    Margherita -> acc + 7
    Formaggio -> acc + 10
    Caprese -> acc + 9
    ExtraSauce(p) -> pizza_price_helper(p, acc + 1)
    ExtraToppings(p) -> pizza_price_helper(p, acc + 2)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let fee = case list.length(order) {
    1 -> 3
    2 -> 2
    _ -> 0
  }
  order_price_helper(order, fee)
}

fn order_price_helper(order: List(Pizza), acc: Int) -> Int {
  case order {
    [] -> acc
    [pizza, ..rest] -> order_price_helper(rest, acc + pizza_price(pizza))
  }
}

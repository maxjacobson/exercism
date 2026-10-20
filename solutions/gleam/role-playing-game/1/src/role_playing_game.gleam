import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(name) -> name
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health == 0 {
    True -> {
      case player.level >= 10 {
        True -> {
          Some(Player(..player, health: 100, mana: Some(100)))
        }
        False -> {
          Some(Player(..player, health: 100))
        }
      }
    }
    False -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    Some(mana) if mana >= cost -> {
      #(Player(..player, mana: Some(mana - cost)), cost * 2)
    }
    Some(_) -> {
      #(player, 0)
    }
    None -> {
      let new_health = player.health - cost
      case new_health >= 0 {
        True -> #(Player(..player, health: new_health), 0)
        False -> #(Player(..player, health: 0), 0)
      }
    }
  }
}

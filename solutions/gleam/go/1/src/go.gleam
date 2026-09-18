pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  case rule1(game) {
    Ok(rule1_game) -> {
      case rule2(rule1_game) |> rule3 {
        Ok(rule3_game) -> {
          case rule4(rule3_game) {
            Ok(rule4_game) ->
              Game(..rule4_game, player: swap_player(rule4_game))
            Error(error) -> Game(..game, error: error)
          }
        }
        Error(error) -> Game(..game, error: error)
      }
    }
    Error(error) -> {
      Game(..game, error: error)
    }
  }
}

fn swap_player(game: Game) -> Player {
  case game.player {
    White -> Black
    Black -> White
  }
}

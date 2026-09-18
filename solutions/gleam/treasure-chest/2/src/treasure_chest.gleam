// Please define the TreasureChest generic custom type

// Please define the UnlockResult generic custom type

pub type TreasureChest(treasure) {
  TreasureChest(String, treasure)
}

pub type UnlockResult(treasure) {
  Unlocked(treasure)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest {
    TreasureChest(pw, value) if pw == password -> Unlocked(value)
    _ -> WrongPassword
  }
}

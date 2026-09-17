import gleam/result
import gleam/string

pub fn first_letter(name: String) {
  string.trim(name) |> string.first |> result.unwrap("")
}

pub fn initial(name: String) {
  { first_letter(name) |> string.capitalise } <> "."
}

pub fn initials(full_name: String) {
  case string.split(full_name, " ") {
    [first, last] -> initial(first) <> " " <> initial(last)
    _ -> todo
  }
}

pub fn pair(full_name1: String, full_name2: String) {
  let ascii =
    "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     X. X.  +  X. X.     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
    |> string.replace(
      "X. X.  +  X. X.",
      initials(full_name1) <> "  +  " <> initials(full_name2),
    )

  ascii
}

import gleam/list
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(path) {
    Ok(contents) -> contents |> string.trim_end |> string.split("\n") |> Ok
    _ -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case simplifile.create_file(path) {
    Ok(_) -> Ok(Nil)
    _ -> Error(Nil)
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  case simplifile.append(to: path, contents: email <> "\n") {
    Ok(_) -> Ok(Nil)
    _ -> Error(Nil)
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  case create_log_file(log_path) {
    Ok(_) -> {
      case read_emails(emails_path) {
        Ok(emails) -> {
          list.map(emails, fn(email) {
            case send_email(email) {
              Ok(_) -> {
                log_sent_email(log_path, email)
              }
              _ -> {
                Ok(Nil)
              }
            }
          })

          Ok(Nil)
        }
        _ -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}

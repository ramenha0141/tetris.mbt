///|
pub(all) enum Cell {
  Empty
  I
  J
  L
  O
  S
  T
  Z
} derive(Show, Eq, Hash)

///|
pub impl Default for Cell with default() -> Cell {
  Cell::Empty
}

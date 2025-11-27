///|
pub(all) enum Rotation {
  DEG_0
  DEG_90
  DEG_180
  DEG_270
} derive(Show, Eq, Hash)

///|
pub fn Rotation::rotate_right(self : Self) -> Self {
  match self {
    DEG_0 => DEG_90
    DEG_90 => DEG_180
    DEG_180 => DEG_270
    DEG_270 => DEG_0
  }
}

///|
pub fn Rotation::rotate_left(self : Self) -> Self {
  match self {
    DEG_0 => DEG_270
    DEG_90 => DEG_0
    DEG_180 => DEG_90
    DEG_270 => DEG_180
  }
}

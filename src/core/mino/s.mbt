///|
let s_matrix : Matrix[Cell] = Matrix::from_pattern(Vec2::new(3, 3), Cell::S, [
  [0, 1, 1],
  [1, 1, 0],
  [0, 0, 0],
])

///|
pub fn Mino::get_s() -> Self {
  Mino::new(default_mino_pos, s_matrix, default_rotation_pattern)
}

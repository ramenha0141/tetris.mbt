///|
let o_matrix : Matrix[Cell] = Matrix::from_pattern(Vec2::new(2, 2), Cell::O, [
  [1, 1],
  [1, 1],
])

///|
pub fn Mino::get_o() -> Self {
  Mino::new(default_mino_pos, o_matrix, default_rotation_pattern)
}

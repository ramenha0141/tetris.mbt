///|
let l_matrix : Matrix[Cell] = Matrix::from_pattern(Vec2::new(3, 3), Cell::L, [
  [0, 0, 1],
  [1, 1, 1],
  [0, 0, 0],
])

///|
pub fn Mino::get_l() -> Self {
  Mino::new(default_mino_pos, l_matrix, default_rotation_pattern)
}

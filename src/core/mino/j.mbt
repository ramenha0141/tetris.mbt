///|
let j_matrix : Matrix[Cell] = Matrix::from_pattern(Vec2::new(3, 3), Cell::J, [
  [1, 0, 0],
  [1, 1, 1],
  [0, 0, 0],
])

///|
pub fn Mino::get_j() -> Self {
  Mino::new(default_mino_pos, j_matrix, default_rotation_pattern)
}

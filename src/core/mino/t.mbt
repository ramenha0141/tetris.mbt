///|
let t_matrix : Matrix[Cell] = Matrix::from_pattern(Vec2::new(3, 3), Cell::T, [
  [0, 1, 0],
  [1, 1, 1],
  [0, 0, 0],
])

///|
pub fn Mino::get_t() -> Self {
  Mino::new(default_mino_pos, t_matrix, default_rotation_pattern)
}

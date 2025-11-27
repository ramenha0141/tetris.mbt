///|
let z_matrix : Matrix[Cell] = Matrix::from_pattern(Vec2::new(3, 3), Cell::Z, [
  [1, 1, 0],
  [0, 1, 1],
  [0, 0, 0],
])

///|
pub fn Mino::get_z() -> Self {
  Mino::new(default_mino_pos, z_matrix, default_rotation_pattern)
}

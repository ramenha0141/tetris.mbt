///|
let i_matrix : Matrix[Cell] = Matrix::from_pattern(Vec2::new(4, 4), Cell::I, [
  [0, 0, 0, 0],
  [1, 1, 1, 1],
  [0, 0, 0, 0],
  [0, 0, 0, 0],
])

///|
let i_rotation_pattern : RotationPattern = Map::from_array([
  (
    (Rotation::DEG_0, Rotation::DEG_90),
    [
      Vec2::zero(),
      Vec2::new(-2, 0),
      Vec2::new(1, 0),
      Vec2::new(-2, 1),
      Vec2::new(1, -2),
    ],
  ),
  (
    (Rotation::DEG_90, Rotation::DEG_180),
    [
      Vec2::zero(),
      Vec2::new(-1, 0),
      Vec2::new(2, 0),
      Vec2::new(-1, -2),
      Vec2::new(2, 1),
    ],
  ),
  (
    (Rotation::DEG_180, Rotation::DEG_270),
    [
      Vec2::zero(),
      Vec2::new(2, 0),
      Vec2::new(-1, 0),
      Vec2::new(2, -1),
      Vec2::new(-1, 2),
    ],
  ),
  (
    (Rotation::DEG_270, Rotation::DEG_0),
    [
      Vec2::zero(),
      Vec2::new(1, 0),
      Vec2::new(-2, 0),
      Vec2::new(1, 2),
      Vec2::new(-2, -1),
    ],
  ),
  (
    (Rotation::DEG_0, Rotation::DEG_270),
    [
      Vec2::zero(),
      Vec2::new(-1, 0),
      Vec2::new(2, 0),
      Vec2::new(-1, -2),
      Vec2::new(2, 1),
    ],
  ),
  (
    (Rotation::DEG_270, Rotation::DEG_180),
    [
      Vec2::zero(),
      Vec2::new(-2, 0),
      Vec2::new(1, 0),
      Vec2::new(-2, 1),
      Vec2::new(1, -2),
    ],
  ),
  (
    (Rotation::DEG_180, Rotation::DEG_90),
    [
      Vec2::zero(),
      Vec2::new(1, 0),
      Vec2::new(-2, 0),
      Vec2::new(1, 2),
      Vec2::new(-2, -1),
    ],
  ),
  (
    (Rotation::DEG_90, Rotation::DEG_0),
    [
      Vec2::zero(),
      Vec2::new(2, 0),
      Vec2::new(-1, 0),
      Vec2::new(2, -1),
      Vec2::new(-1, 2),
    ],
  ),
])

///|
pub fn Mino::get_i() -> Self {
  Mino::new(default_mino_pos, i_matrix, i_rotation_pattern)
}

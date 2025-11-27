///|
let default_mino_pos : Vec2 = Vec2::new(3, 0)

///|
type RotationPattern = Map[(Rotation, Rotation), FixedArray[Vec2]]

///|
let default_rotation_pattern : RotationPattern = Map::from_array([
  (
    (Rotation::DEG_0, Rotation::DEG_90),
    [
      Vec2::zero(),
      Vec2::new(-1, 0),
      Vec2::new(-1, -1),
      Vec2::new(0, 2),
      Vec2::new(-1, 2),
    ],
  ),
  (
    (Rotation::DEG_90, Rotation::DEG_180),
    [
      Vec2::zero(),
      Vec2::new(1, 0),
      Vec2::new(1, 1),
      Vec2::new(0, -2),
      Vec2::new(1, -2),
    ],
  ),
  (
    (Rotation::DEG_180, Rotation::DEG_270),
    [
      Vec2::zero(),
      Vec2::new(1, 0),
      Vec2::new(1, -1),
      Vec2::new(0, 2),
      Vec2::new(1, 2),
    ],
  ),
  (
    (Rotation::DEG_270, Rotation::DEG_0),
    [
      Vec2::zero(),
      Vec2::new(-1, 0),
      Vec2::new(-1, 1),
      Vec2::new(0, -2),
      Vec2::new(-1, -2),
    ],
  ),
  (
    (Rotation::DEG_0, Rotation::DEG_270),
    [
      Vec2::zero(),
      Vec2::new(1, 0),
      Vec2::new(1, -1),
      Vec2::new(0, 2),
      Vec2::new(1, 2),
    ],
  ),
  (
    (Rotation::DEG_270, Rotation::DEG_180),
    [
      Vec2::zero(),
      Vec2::new(-1, 0),
      Vec2::new(-1, 1),
      Vec2::new(0, -2),
      Vec2::new(-1, -2),
    ],
  ),
  (
    (Rotation::DEG_180, Rotation::DEG_90),
    [
      Vec2::zero(),
      Vec2::new(-1, 0),
      Vec2::new(-1, -1),
      Vec2::new(0, 2),
      Vec2::new(-1, 2),
    ],
  ),
  (
    (Rotation::DEG_90, Rotation::DEG_0),
    [
      Vec2::zero(),
      Vec2::new(1, 0),
      Vec2::new(1, 1),
      Vec2::new(0, -2),
      Vec2::new(1, -2),
    ],
  ),
])

///|
struct MinoInitialState {
  pos : Vec2
  matrix : Matrix[Cell]
  rotation : Rotation
}

///|
pub struct Mino {
  mut pos : Vec2
  mut matrix : Matrix[Cell]
  mut rotation : Rotation
  initial_state : MinoInitialState
  rotation_pattern : RotationPattern
}

///|
pub fn Mino::new(
  pos : Vec2,
  matrix : Matrix[Cell],
  rotation_pattern : RotationPattern,
) -> Self {
  Mino::{
    pos,
    matrix,
    rotation: DEG_0,
    initial_state: MinoInitialState::{ pos, matrix, rotation: DEG_0 },
    rotation_pattern,
  }
}

///|
pub fn Mino::reset(self : Self) -> Unit {
  self.pos = self.initial_state.pos
  self.matrix = self.initial_state.matrix
  self.rotation = self.initial_state.rotation
}

///|
pub fn Mino::move_left(self : Self, board : Matrix[Cell]) -> Bool {
  let pos = self.pos + Vec2::new(-1, 0)
  if board.is_colliding(self.matrix, pos) {
    return false
  }
  self.pos = pos
  true
}

///|
pub fn Mino::move_right(self : Self, board : Matrix[Cell]) -> Bool {
  let pos = self.pos + Vec2::new(1, 0)
  if board.is_colliding(self.matrix, pos) {
    return false
  }
  self.pos = pos
  true
}

///|
pub fn Mino::move_down(self : Self, board : Matrix[Cell]) -> Bool {
  let pos = self.pos + Vec2::new(0, 1)
  if board.is_colliding(self.matrix, pos) {
    return false
  }
  self.pos = pos
  true
}

///|
pub fn Mino::rotate_left(self : Self, board : Matrix[Cell]) -> Bool {
  let matrix = self.matrix.rotate_left()
  let rotation = self.rotation.rotate_left()
  for offset in self.rotation_pattern.get((self.rotation, rotation)).unwrap() {
    let pos = self.pos + offset
    if !board.is_colliding(matrix, pos) {
      self.pos = pos
      self.matrix = matrix
      self.rotation = rotation
      return true
    }
  }
  false
}

///|
pub fn Mino::rotate_right(self : Self, board : Matrix[Cell]) -> Bool {
  let matrix = self.matrix.rotate_right()
  let rotation = self.rotation.rotate_right()
  for offset in self.rotation_pattern.get((self.rotation, rotation)).unwrap() {
    let pos = self.pos + offset
    if !board.is_colliding(matrix, pos) {
      self.pos = pos
      self.matrix = matrix
      self.rotation = rotation
      return true
    }
  }
  false
}

///|
pub fn Mino::get_drop_pos(self : Self, board : Matrix[Cell]) -> Vec2 {
  let mut pos = self.pos
  while !board.is_colliding(self.matrix, pos + Vec2::new(0, 1)) {
    pos = pos + Vec2::new(0, 1)
  }
  pos
}

///|
pub fn Mino::drop(self : Self, board : Matrix[Cell]) -> Bool {
  self.pos = self.get_drop_pos(board)
  true
}

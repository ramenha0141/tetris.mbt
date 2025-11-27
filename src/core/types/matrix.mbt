///|
pub struct Matrix[T] {
  size : Vec2
  data : FixedArray[T]
} derive(Show)

///|
pub fn[T] Matrix::new(size : Vec2, data : FixedArray[T]) -> Self[T] {
  Matrix::{ size, data }
}

///|
pub fn[T : Default] Matrix::empty(size : Vec2) -> Self[T] {
  Matrix::new(size, FixedArray::make(size.area(), T::default()))
}

///|
pub fn[T] Matrix::from_iter(size : Vec2, iter : Iter[T]) -> Self[T] {
  Matrix::{ size, data: FixedArray::from_iter(iter) }
}

///|
pub fn[T : Default] Matrix::from_pattern(
  size : Vec2,
  value : T,
  pattern : FixedArray[FixedArray[Int]],
) -> Self[T] {
  let matrix = Matrix::empty(size)
  for pos in size.iter() {
    if pattern[pos.y][pos.x] != 0 {
      matrix.set_mut(pos, value)
    }
  }
  matrix
}

///|
pub fn[T] Matrix::copy(self : Matrix[T]) -> Self[T] {
  Matrix::{ size: self.size, data: self.data.copy() }
}

///|
fn[T] Matrix::is_in_bounds(self : Matrix[T], pos : Vec2) -> Bool {
  pos.x >= 0 && pos.x < self.size.x && pos.y >= 0 && pos.y < self.size.y
}

///|
fn[T] Matrix::get_index(self : Matrix[T], pos : Vec2) -> Int {
  if !self.is_in_bounds(pos) {
    panic()
  }
  pos.x + pos.y * self.size.x
}

///|
pub fn[T] Matrix::get(self : Matrix[T], pos : Vec2) -> T {
  self.data[self.get_index(pos)]
}

///|
pub fn[T : Default + Eq] Matrix::is_empty_at(
  self : Matrix[T],
  pos : Vec2,
) -> Bool {
  self.get(pos) == T::default()
}

///|
pub fn[T] Matrix::set_mut(self : Self[T], pos : Vec2, value : T) -> Unit {
  self.data[self.get_index(pos)] = value
}

///|
pub fn[T] Matrix::set(self : Matrix[T], pos : Vec2, value : T) -> Self[T] {
  let result = self.copy()
  result.set_mut(pos, value)
  result
}

///|
pub fn[T : Default + Eq] Matrix::put_mut(
  self : Self[T],
  pos : Vec2,
  value : T,
) -> Unit {
  if self.get(pos) == T::default() {
    self.set_mut(pos, value)
  }
}

///|
pub fn[T : Default + Eq] Matrix::put(
  self : Matrix[T],
  pos : Vec2,
  value : T,
) -> Self[T] {
  let result = self.copy()
  result.put_mut(pos, value)
  result
}

///|
pub fn[T] Matrix::iter(self : Matrix[T]) -> Iter[(Vec2, T)] {
  Iter::new(yield_ => outer~: for i, p in self.size.iter() {
    guard yield_((p, self.data[i])) is IterContinue else {
      break outer~ IterEnd
    }
  } else {
    IterContinue
  })
}

///|
pub fn[T : Default + Eq] Matrix::is_colliding(
  self : Matrix[T],
  other : Matrix[T],
  offset : Vec2,
) -> Bool {
  for t in other.iter() {
    let (pos, value) = t
    let pos = pos + offset
    if value != T::default() &&
      (!self.is_in_bounds(pos) || self.get(pos) != T::default()) {
      return true
    }
  }
  false
}

///|
pub fn[T : Default + Eq] Matrix::overlay(
  self : Matrix[T],
  other : Matrix[T],
  offset : Vec2,
) -> Matrix[T] {
  let result = self.copy()
  for t in other.iter() {
    let (pos, value) = t
    let pos = pos + offset
    if result.is_in_bounds(pos) && value != T::default() {
      result.set_mut(pos, value)
    }
  }
  result
}

///|
pub fn[T : Default] Matrix::rotate_right(self : Self[T]) -> Self[T] {
  let result : Matrix[T] = Matrix::empty(self.size)
  for t in self.iter() {
    let (pos, value) = t
    result.set_mut(Vec2::new(self.size.y - pos.y - 1, pos.x), value)
  }
  result
}

///|
pub fn[T : Default] Matrix::rotate_left(self : Self[T]) -> Self[T] {
  let result : Matrix[T] = Matrix::empty(self.size)
  for t in self.iter() {
    let (pos, value) = t
    result.set_mut(Vec2::new(pos.y, self.size.x - pos.x - 1), value)
  }
  result
}

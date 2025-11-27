///|
fn[T] Matrix::iter_lines(self : Matrix[T]) -> Iter[ArrayView[T]] {
  Iter::new(yield_ => for y in 0..<self.size.y {
    guard yield_(self.data[self.size.x * y:self.size.x * (y + 1)])
      is IterContinue else {
      break IterEnd
    }
  } else {
    IterContinue
  })
}

///|
fn Matrix::highest_line(self : Matrix[Cell]) -> Int {
  for y, line in self.iter_lines() {
    if line.any(cell => cell != Cell::Empty) {
      return y
    }
  }
  self.size.y
}

///|
fn Matrix::remove_full_lines(self : Matrix[Cell]) -> Matrix[Cell] {
  let result = self.copy()
  let empty_lines = self
    .iter_lines()
    .mapi((y, line) => (y, line))
    .filter(t => t.1.all(cell => cell != Cell::Empty))
    .map(t => t.0)
    .collect()
  let highest_line = self.highest_line()
  for y in empty_lines {
    for dy = y; dy >= highest_line; dy = dy - 1 {
      for x in 0..<self.size.x {
        result.set_mut(Vec2::new(x, dy), result.get(Vec2::new(x, dy - 1)))
      }
    }
  }
  result
}

///|
pub struct Vec2 {
  x : Int
  y : Int
} derive(Show)

///|
pub fn Vec2::new(x : Int, y : Int) -> Self {
  Vec2::{ x, y }
}

///|
pub fn Vec2::zero() -> Self {
  Vec2::{ x: 0, y: 0 }
}

///|
pub fn Vec2::area(self : Self) -> Int {
  self.x * self.y
}

///|
pub fn Vec2::scale(self : Self, scalar : Int) -> Self {
  { x: self.x * scalar, y: self.y * scalar }
}

///|
pub fn Vec2::swap(self : Self) -> Self {
  { x: self.y, y: self.x }
}

///|
pub impl Add for Vec2 with add(self : Vec2, other : Vec2) -> Vec2 {
  { x: self.x + other.x, y: self.y + other.y }
}

///|
pub impl Sub for Vec2 with sub(self : Vec2, other : Vec2) -> Vec2 {
  { x: self.x - other.x, y: self.y - other.y }
}

///|
pub impl Eq for Vec2 with equal(self : Vec2, other : Vec2) -> Bool {
  self.x == other.x && self.y == other.y
}

///|
pub fn Vec2::iter(self : Self) -> Iter[Self] {
  Iter::new(yield_ => outer~: for y in 0..<self.y {
    for x in 0..<self.x {
      guard yield_(Vec2::new(x, y)) is IterContinue else {
        break outer~ IterEnd
      }
    }
  } else {
    IterContinue
  })
}

///|
test "vec2" {
  let a = Vec2::new(1, 2)
  let b = Vec2::new(3, 4)
  assert_eq(a + b, Vec2::new(4, 6))
  assert_eq(b - a, Vec2::new(2, 2))
  assert_eq(a == a, true)
  assert_eq(a == b, false)
  assert_eq(a.iter().collect()[0], Vec2::new(0, 0))
  assert_eq(a.iter().collect()[1], Vec2::new(0, 1))
}

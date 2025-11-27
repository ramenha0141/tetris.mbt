///|
const NEXT_MINOS = 5

///|
const FALL_RATE = 50

///|
const WIDTH = 10

///|
const HEIGHT = 20

///|
let size : Vec2 = Vec2::new(WIDTH, HEIGHT)

///|
pub struct Game {
  mut is_game_over : Bool
  mut board : Matrix[Cell]
  mut current_mino : Mino
  next_mino : @queue.Queue[Mino]
  mut hold_mino : Mino?
  mut can_hold : Bool
  mut ghost_position : Vec2
  mut fall_timer : Int
}

///|
pub fn Game::new() -> Self {
  let board = Matrix::empty(size)
  let next_mino = @queue.Queue::from_array(Mino::create_bag())
  let current_mino = next_mino.pop().unwrap()
  Game::{
    is_game_over: false,
    board,
    current_mino,
    next_mino,
    hold_mino: None,
    can_hold: true,
    ghost_position: current_mino.get_drop_pos(board),
    fall_timer: 0,
  }
}

///|
pub fn Game::update_next_mino(self : Self) -> Unit {
  if self.next_mino.length() < NEXT_MINOS {
    let bag = Mino::create_bag()
    for mino in bag {
      self.next_mino.push(mino)
    }
  }
}

///|
pub fn Game::update_ghost_position(self : Self) -> Unit {
  self.ghost_position = self.current_mino.get_drop_pos(self.board)
}

///|
fn Game::is_touching_floor(self : Self) -> Bool {
  self.board.is_colliding(
    self.current_mino.matrix,
    self.current_mino.pos + Vec2::new(0, 1),
  )
}

///|
pub fn Game::next(self : Self) -> Unit {
  self.current_mino = self.next_mino.pop().unwrap()
  self.update_next_mino()
  self.update_ghost_position()
  self.fall_timer = 0
  if self.board.is_colliding(self.current_mino.matrix, self.current_mino.pos) {
    self.is_game_over = true
    @dom.window().alert("Game Over")
  }
}

///|
pub fn Game::move_left(self : Self) -> Bool {
  if self.current_mino.move_left(self.board) {
    self.update_ghost_position()
    if self.is_touching_floor() {
      self.fall_timer = 0
    }
    return true
  }
  false
}

///|
pub fn Game::move_right(self : Self) -> Bool {
  if self.current_mino.move_right(self.board) {
    self.update_ghost_position()
    if self.is_touching_floor() {
      self.fall_timer = 0
    }
    return true
  }
  false
}

///|
pub fn Game::move_down(self : Self) -> Bool {
  if self.current_mino.move_down(self.board) {
    self.fall_timer = 0
    return true
  }
  false
}

///|
pub fn Game::rotate_left(self : Self) -> Bool {
  if self.current_mino.rotate_left(self.board) {
    self.update_ghost_position()
    if self.is_touching_floor() {
      self.fall_timer = 0
    }
    return true
  }
  false
}

///|
pub fn Game::rotate_right(self : Self) -> Bool {
  if self.current_mino.rotate_right(self.board) {
    self.update_ghost_position()
    if self.is_touching_floor() {
      self.fall_timer = 0
    }
    return true
  }
  false
}

///|
pub fn Game::drop(self : Self) -> Bool {
  if self.current_mino.drop(self.board) {
    self.place()
    return true
  }
  false
}

///|
pub fn Game::hold(self : Self) -> Bool {
  if self.can_hold {
    self.current_mino.reset()
    match self.hold_mino {
      Some(mino) => {
        self.hold_mino = Some(self.current_mino)
        self.current_mino = mino
      }
      None => {
        self.hold_mino = Some(self.current_mino)
        self.next()
      }
    }
    self.can_hold = false
    return true
  }
  false
}

///|
pub fn Game::place(self : Self) -> Unit {
  let mino = self.current_mino
  self.board = self.board.overlay(mino.matrix, mino.pos).remove_full_lines()
  self.next()
  self.can_hold = true
}

///|
pub fn Game::tick(self : Self) -> Unit {
  if self.is_game_over {
    return
  }
  if self.fall_timer < FALL_RATE {
    self.fall_timer += 1
  } else if !self.move_down() {
    self.place()
  }
}

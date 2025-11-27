///|
const DAS = 8

///|
const ARR = 2

///|
struct InputMap[T] {
  mut left : T
  mut right : T
  mut down : T
} derive(Default)

///|
pub struct Controller {
  game : Game
  input : InputMap[Bool]
  das_timer : InputMap[Int]
  arr_timer : InputMap[Int]
}

///|
pub fn Controller::new(game : Game) -> Self {
  Controller::{
    game,
    input: InputMap::default(),
    das_timer: InputMap::default(),
    arr_timer: InputMap::default(),
  }
}

///|
pub fn Controller::key_down(self : Self, key : String) -> Unit {
  if self.game.is_game_over {
    return
  }
  let _ = match key {
    "ArrowLeft" => {
      self.input.left = true
      self.game.move_left()
    }
    "ArrowRight" => {
      self.input.right = true
      self.game.move_right()
    }
    "ArrowDown" => {
      self.input.down = true
      self.game.move_down()
    }
    "KeyZ" => self.game.rotate_left()
    "KeyX" => self.game.rotate_right()
    "ShiftLeft" => self.game.hold()
    "Space" => self.game.drop()
    _ => false
  }

}

///|
pub fn Controller::key_up(self : Self, key : String) -> Unit {
  if self.game.is_game_over {
    return
  }
  match key {
    "ArrowLeft" => {
      self.input.left = false
      self.das_timer.left = 0
      self.arr_timer.left = 0
    }
    "ArrowRight" => {
      self.input.right = false
      self.das_timer.right = 0
      self.arr_timer.right = 0
    }
    "ArrowDown" => {
      self.input.down = false
      self.das_timer.down = 0
      self.arr_timer.down = 0
    }
    _ => ()
  }
}

///|
pub fn Controller::tick(self : Self) -> Unit {
  if self.game.is_game_over {
    return
  }
  if self.input.left {
    if self.das_timer.left < DAS {
      self.das_timer.left += 1
    } else if self.arr_timer.left < ARR {
      self.arr_timer.left += 1
    } else if self.game.move_left() {
      self.arr_timer.left = 0
    }
  }
  if self.input.right {
    if self.das_timer.right < DAS {
      self.das_timer.right += 1
    } else if self.arr_timer.right < ARR {
      self.arr_timer.right += 1
    } else if self.game.move_right() {
      self.arr_timer.right = 0
    }
  }
  if self.input.down {
    if self.arr_timer.down < ARR {
      self.arr_timer.down += 1
    } else if self.game.move_down() {
      self.arr_timer.down = 0
    }
  }
}

///|
let rng : @random.Rand = @random.Rand::chacha8(seed = b"MOONBIT ADVENT CALENDAR 2025 RNG")

///|
fn rand(limit : Int) -> Int {
  rng.int(limit~)
}

///|
pub fn Mino::create_bag() -> Array[Mino] {
  [
    Mino::get_i(),
    Mino::get_j(),
    Mino::get_l(),
    Mino::get_o(),
    Mino::get_s(),
    Mino::get_t(),
    Mino::get_z(),
  ].shuffle(rand~)
}

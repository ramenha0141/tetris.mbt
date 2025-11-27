///|
let board_offset : Vec2 = Vec2::new(5, 0)

///|
pub fn render(
  game_state : Game,
  ctx : @canvas.CanvasRenderingContext2D,
  cell_size : Double,
) -> Unit {
  let width = ctx.canvas.width.to_double()
  let height = ctx.canvas.height.to_double()
  ctx.clear_rect(0, 0, width, height)
  ctx.fillStyle = "#aaa"
  ctx.fill_rect(0, 0, width, height)
  fn render_cell(pos : Vec2, cell : Cell, ghost : Bool) -> Unit {
    let color = colors.get(cell).unwrap()
    ctx.fillStyle = if ghost { color + "a0" } else { color }
    ctx.fill_rect(
      (cell_size + 1) * (pos.x.to_double() + 1),
      (cell_size + 1) * (pos.y.to_double() + 1),
      cell_size,
      cell_size,
    )
  }

  for t in game_state.board.iter() {
    let (pos, cell) = t
    render_cell(pos + board_offset, cell, false)
  }
  for t in game_state.current_mino.matrix.iter() {
    let (pos, cell) = t
    if cell != Cell::Empty {
      render_cell(pos + game_state.current_mino.pos + board_offset, cell, false)
      render_cell(pos + game_state.ghost_position + board_offset, cell, true)
    }
  }
  match game_state.hold_mino {
    Some(mino) =>
      for t in mino.matrix.iter() {
        let (pos, cell) = t
        if cell != Cell::Empty {
          render_cell(pos + Vec2::new(1, 1), cell, false)
        }
      }
    _ => ()
  }
  for i, mino in game_state.next_mino.iter()[0:5] {
    for t in mino.matrix.iter() {
      let (pos, cell) = t
      if cell != Cell::Empty {
        render_cell(pos + mino.pos + Vec2::new(13, 1 + i * 4), cell, false)
      }
    }
  }
}

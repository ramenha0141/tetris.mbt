///|
const CELL_SIZE = 39.0

///|
const TICK_RATE = 60

///|
async fn main {
  let game_state = @core.Game::new()
  let controller = @controller.Controller::new(game_state)
  let _ = @js.set_interval(
    () => {
      game_state.tick()
      controller.tick()
    },
    1000 / TICK_RATE,
  )
  @dom.window().addEventListener("keydown", _event => {
    let event : @dom.KeyboardEvent = _event |> @js.identity()
    if !event.repeat {
      controller.key_down(event.code)
    }
  })
  @dom.window().addEventListener("keyup", _event => {
    let event : @dom.KeyboardEvent = _event |> @js.identity()
    if !event.repeat {
      controller.key_up(event.code)
    }
  })
  let canvas : @dom.HTMLCanvasElement = @dom.document()
    .get_element_by_id("canvas")
    .unwrap()
    |> @js.identity()
  let ctx : @canvas.CanvasRenderingContext2D = canvas.getContext("2d")
    |> @js.identity()
  while true {
    @dom.wait_animation_frame()
    @renderer.render(game_state, ctx, CELL_SIZE)
  }
}

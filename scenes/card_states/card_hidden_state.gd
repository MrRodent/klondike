extends CardState


func enter() -> void:
	if not card_ui.is_node_ready():
		await  card_ui.ready
	
	# NOTE: staten debugaukseen
	card_ui.color.color = Color.WEB_MAROON
	card_ui.color.size = Vector2(38, 56)
	card_ui.color.position = Vector2(2, 2)
	card_ui.state.text = "HIDDEN"
	card_ui.pivot_offset = Vector2.ZERO


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		if card_ui.is_last_sibling():
			card_ui.is_hidden = false
			transition_requested.emit(self, CardState.State.BASE)

extends CardState

# NOTE: HIDDEN cards can't enter this state
func enter() -> void:
	# NOTE: staten debugaukseen
	card_ui.color.color = Color.ORANGE
	card_ui.state.text = "CLICKED"
	# Nyt kun tapahtuu, halutaan monitorointi päälle
	card_ui.drop_point_detector.monitoring = true
	
	if card_ui.card:
		print('clicked ', card_ui.card.id, ' colour: ', card_ui.card.colour)

func on_input(event: InputEvent) -> void:
	#if card_ui.is_hidden and event.is_action_released("left_mouse"):
		#card_ui.is_hidden = false
		#transition_requested.emit(self, CardState.State.BASE)
	
	if card_ui.is_hidden:
		transition_requested.emit(self, CardState.State.HIDDEN)
	
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)

extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05

var is_minimum_drag_time_elapsed := false

func enter() -> void:
	# We check that the group exists, and if so, we reparent it.
	# Remember that reparenting is done so that the card wont be
	# stuck in the VBox container.
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
		#print(card_ui.get_parent())
	
	# NOTE: staten debugaukseen
	card_ui.color.color = Color.NAVY_BLUE
	card_ui.color.size = Vector2(38, 16)
	card_ui.color.position = Vector2(2, 22)
	card_ui.state.text = "DRAGGING"
	
	card_ui.z_index = 1
	is_minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): is_minimum_drag_time_elapsed = true)


func on_input(event: InputEvent) -> void:
	# We set some flags
	var mouse_motion := event is InputEventMouseMotion
	#var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	#TODO: canceliä ei välttis tarvita?
	#if cancel:
		#transition_requested.emit(self, CardState.State.BASE)
	elif is_minimum_drag_time_elapsed and confirm:
		# Set handled so we cant accidentally instantly pick up a new card
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)

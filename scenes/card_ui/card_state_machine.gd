class_name CardStateMachine
extends Node

@export var initial_state: CardState
@export var revealed_state: CardState

var current_state: CardState
var states := {}


func init(card: CardUI) -> void:
	for child in get_children():
		if child is CardState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card
	
	if initial_state:
		if card.is_last_sibling():
			revealed_state.enter()
			current_state = revealed_state
		else:
			initial_state.enter()
			current_state = initial_state
		card.current_parent = card.get_parent()


func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)


func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)


func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()


func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()


func _on_transition_requested(from: CardState, to: CardState.State) -> void:
	# Jos from ja to on eri, jotain meni todella pieleen ja palataan
	if from != current_state:
		return
	
	var new_state: CardState = states[to]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state

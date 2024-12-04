extends CardState

var is_played: bool

func enter() -> void:
	# NOTE: staten debugaukseen
	card_ui.color.color = Color.DARK_VIOLET
	card_ui.state.text = "RELEASED"
	
	is_played = false
	
	# Turns colour back to normal
	card_ui.texture.modulate = Color.WHITE
	
	# Kortin pelaaminen
	if not card_ui.targets.is_empty():
		# TODO: tähän jos saisi paremman pätkän kuin tämän get_parent ketjutuksen.
		# targets[-1] ottaa arrayn viimeisen
		var last_item_in_column = card_ui.targets[-1].get_parent().get_parent().get_child(-1)
		#print("last item in column: ", last_item_in_column, " class: ", last_item_in_column.get_class())
		
		if last_item_in_column.get_class() == "Control": # TODO: tähän joku luotettavampi check
			if last_item_in_column.is_hidden:
				print("INVALID: hidden card")
				card_ui.z_index = 0
				return
			elif card_ui.card.colour == last_item_in_column.card.colour:
				print("INVALID: same colour")
				card_ui.z_index = 0
				return
			elif card_ui.card.number + 1 != last_item_in_column.card.number:
				print("INVALID: wrong number")
				card_ui.z_index = 0
				return
			#print("played ", card_ui.card.id, " on ", last_item_in_column.card.id)
		
		is_played = true
		card_ui.z_index = 0
		
		#print("play card for target(s)", card_ui.targets)
		#TODO: pura tämäkin hökötys
		var new_parent = card_ui.targets[-1].get_parent().get_parent()
		card_ui.reparent(new_parent)
		card_ui.current_parent = new_parent
		#print("NEW PARENT: ", new_parent)
		
		if card_ui.child_column:
			for child in card_ui.child_column.get_children():
				child.reparent(new_parent)
				child.texture.modulate = Color.WHITE
			#print("this card has the following children: ", card_ui.child_column.get_children())


func on_input(_event: InputEvent) -> void:
	transition_requested.emit(self, CardState.State.BASE)
	
	if not is_played:
		card_ui.reparent(card_ui.current_parent)

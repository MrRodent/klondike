extends CardState


func enter() -> void:
	if not card_ui.is_node_ready():
		await  card_ui.ready
	
	card_ui.is_hidden = false
	
	#TODO: mitä tällä signalilla tekee? oli tutoriaalissa (video 02/08)
	card_ui.reparent_requested.emit(card_ui)
	if card_ui.card:	# TODO: kun kaikki resurssit asetettu, voi poistaa
		card_ui.texture.texture = card_ui.card.art
	card_ui.pivot_offset = Vector2.ZERO
	
	# NOTE: staten debugaukseen
	card_ui.color.color = Color.WEB_GREEN
	#card_ui.color.size = Vector2(38, 16)
	card_ui.color.position = Vector2(2, 22)
	card_ui.state.text = "BASE"


func on_gui_input(event: InputEvent) -> void:
	# Varmistaa onko korttia/kolumnia laillista liikuttaa
	if event.is_action_pressed("left_mouse"):
		#TODO: siivoa kun ei debug
		#if not card_ui.is_last_sibling():
			#return
			#pass
		#else:
			card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
			transition_requested.emit(self, CardState.State.CLICKED)
			# TODO: tämä tapahtumaan paremmassa paikassa?
			create_card_column(card_ui)


func create_card_column(clicked_card: CardUI) -> void:
	var array = clicked_card.get_parent().get_children()
	var index = array.find(clicked_card)
	var cards_in_array = array.size() - 1
	#print("skidit: ", array)
	#print("clicked_card index: ", index, " cards in array: ", cards_in_array)
	if index == cards_in_array:
		print("no cards on top of ", clicked_card.card.id)
		return
	
	# Create a new VBoxContainer instance
	var vbox = VBoxContainer.new()
	# Set the theme constants for the VBoxContainer
	# defaults: separation -45, position (0, 15)
	vbox.add_theme_constant_override("separation", -50)
	vbox.set_position(Vector2(0, 10))
	
	for i in range(cards_in_array - index):
		# Get the next card in the array
		var next_card = array[index + i + 1]
		print("card ", i, " on top: ", next_card.card.id)
		# Reparent the card to the VBoxContainer
		next_card.reparent(vbox)
		# Set the new parent of the card
		next_card.current_parent = vbox
	
	# Add the VBoxContainer to the scene tree
	clicked_card.add_child(vbox)
	clicked_card.child_column = vbox
	#print("current kids: ", clicked_card.get_children())

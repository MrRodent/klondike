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
	card_ui.color.size = Vector2(38, 16)
	card_ui.color.position = Vector2(2, 22)
	card_ui.state.text = "BASE"


func on_gui_input(event: InputEvent) -> void:
	# Varmistaa onko korttia/kolumnia laillista liikuttaa
	if event.is_action_pressed("left_mouse"):
		#TODO: pitää pystyä liikuttamaan jos laillinen kolumni
		if not card_ui.is_last_sibling():
			return
		else:
			card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
			transition_requested.emit(self, CardState.State.CLICKED)
			create_card_column(card_ui)


func create_card_column(clicked_card: CardUI) -> void:
	# Create a new VBoxContainer instance
	var vbox = VBoxContainer.new()
	# Optionally, set properties of the VBoxContainer
	#vbox.custom_minimum_size = Vector2(200, 300)
	# Add the VBoxContainer to the scene tree
	add_child(vbox)

	card_ui.reparent(vbox)
	#vbox.pivot_offset = vbox.get_global_mouse_position() - vbox.global_position
	print("vbox: ", vbox)
	print("current parent: ", card_ui.current_parent)
	print("clicked card: ", clicked_card)
	print("vbox children: ", vbox.get_children())
	
	# loop jos kaikki childit laillisia
	# -> lailliset arrayhyn
	# -> luo VBoxContainer
	# -> lapseta kaikki
	# -> saa liikuttaa

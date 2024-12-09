class_name CardUI
extends Control

#TODO: mitä tällä signalilla tekee? oli tutoriaalissa (video 02/08)
signal reparent_requested(which_card_ui: CardUI)

@export var card: Card

@onready var texture = $Texture
@onready var color = $Color
@onready var state = $State
@onready var drop_point_detector = $DropPointDetector
@onready var card_state_machine = $CardStateMachine
@onready var targets: Array[Node] = []
@onready var current_parent: BoxContainer
@onready var is_hidden: bool = true
@onready var child_column: VBoxContainer = null


func _ready() -> void:
	card_state_machine.init(self)


func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)


func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)


func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()


func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()


func _on_drop_point_detector_area_entered(area: Area2D):
	if not targets.has(area):
		targets.append(area)
		#print("Targets: ", targets)


func _on_drop_point_detector_area_exited(area: Area2D):
	targets.erase(area)
	#print("Targets: ", targets)


func is_last_sibling() -> bool:
	var parent = self.get_parent()
	if parent:
	# Check if the child is the last in the parent's children list
		return parent.get_child(parent.get_child_count() - 1) == self
	return false

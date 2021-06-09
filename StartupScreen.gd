extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var main_game = preload("res://Main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func _input(event):
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
		get_tree().change_scene_to(main_game)

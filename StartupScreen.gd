extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var main_game = preload("res://Main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		get_tree().change_scene_to(main_game)
	pass

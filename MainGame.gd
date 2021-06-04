extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var CircleTscn = preload("res://PoppableCircle.tscn")
var rng = RandomNumberGenerator.new()

var cur_texture = 0
var texture_list = [preload("res://PNG/Default size/pattern03.png"),
					preload("res://PNG/Default size/pattern09.png"),
					preload("res://PNG/Default size/pattern10.png"),
					preload("res://PNG/Default size/pattern11.png"),
					preload("res://PNG/Default size/pattern16.png"),
					preload("res://PNG/Default size/pattern84.png")]
var dir_list = [Vector2(1,1),Vector2(-1,1),Vector2(-1,-1),Vector2(1,-1)]

onready var camera = $Camera
var first = true

onready var score_label = $Label

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	spawn_new_circle()
	GameManager.score_label = $Label
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Circles/Target.position = $Label.rect_size/2.0
	pass
	
func spawn_new_circle():
	if first:
		first = false
	else:
		$Camera.add_trauma(.9)
		
		
	cur_texture+=1 
	$ColorRect.material.set_shader_param("pattern", texture_list[cur_texture%texture_list.size()])
	$ColorRect.material.set_shader_param("dir", dir_list[cur_texture%dir_list.size()])
	
	var new_circle = CircleTscn.instance()
	new_circle.position = Vector2(rng.randi_range(0, get_viewport().size.x), rng.randi_range(0, get_viewport().size.y))
	new_circle.texture = texture_list[(cur_texture+texture_list.size()+1)%texture_list.size()]
	$Circles.add_child(new_circle)
	new_circle.connect("popped", self, "spawn_new_circle")
	
	

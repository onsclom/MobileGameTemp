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

var game_over_required_time = 1.0

onready var camera = $Camera
var first = true

onready var score_label = $Label

var score = 0

var time_to_play = 15.0
var time_spent = 0

var time_spent_done = 0

var startup = true
var starting_time = 0
var startup_total = 1.5
var last_num=-1

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.prev_high_score = GameManager.high_score
	GameManager.score = 0
	rng.randomize()
	GameManager.score_label = $ScoreLabel
	
func start_game():
	spawn_new_circle()
	$CountdownLabel.visible = false
	$ScoreLabel.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Circles/Target.position = $ScoreLabel.rect_size/2.0

	if startup:
		starting_time += delta
		var num = 3-int( starting_time/(startup_total/3) )
		
		if last_num != num:
			last_num = num
			if num==0:
				$Tick2.play()
			else:
				$Tick.play()
		
		$CountdownLabel.text = str(num) 
		if starting_time>startup_total:
			startup=false
			start_game()
			
		return
	
	if time_spent<time_to_play:	
		time_spent += delta
		time_spent = min(time_to_play, time_spent)
		if time_spent == time_to_play:
			do_game_end()
	else:
		time_spent_done += delta
		
	if Input.is_action_just_pressed("left_click") and time_spent_done>game_over_required_time:
		get_tree().reload_current_scene()
		
		
	$ColorRect.material.set_shader_param("percentage", time_spent/time_to_play)
	
func do_game_end():
	for node in get_tree().get_nodes_in_group("circles"):
		node.queue_free()
	$GameOverScreen.visible = true
	
func spawn_new_circle():
	if first:
		first = false
	else:
		$Camera.add_trauma(.9)
		$Explosion.play()
		
	cur_texture+=1 
	$ColorRect.material.set_shader_param("pattern", texture_list[cur_texture%texture_list.size()])
	$ColorRect.material.set_shader_param("dir", dir_list[cur_texture%dir_list.size()])
	
	
	var new_circle = CircleTscn.instance()
	new_circle.position = Vector2(rng.randi_range(0, get_viewport().size.x), rng.randi_range(0, get_viewport().size.y))
	new_circle.texture = texture_list[(cur_texture+texture_list.size()+1)%texture_list.size()]
	$Circles.add_child(new_circle)
	new_circle.connect("popped", self, "spawn_new_circle")
	
	

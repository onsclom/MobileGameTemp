extends Node2D

var target
var wait_time = 1.0
var alive_time = 0

var speed = 100
var close_enough = 40

var rng = RandomNumberGenerator.new()
var rand_dir

var pre_speed = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	rand_dir = Vector2(0,-1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	alive_time += delta
	if target != null and alive_time>wait_time:
		var diff = (target.position-position)
		position += diff * pow((1/diff.length()),2)*speed
		diff = (target.position-position)
		if diff.length() < 10:
			queue_free()
	elif alive_time<wait_time:
		position += rand_dir*(wait_time-alive_time)*pre_speed

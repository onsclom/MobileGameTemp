extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var msg = "Press to play again"
var dots = ["",".","..","...","..","."]
var cur_time = 0
var speed = 4

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cur_time += delta
	text = msg+dots[int(cur_time*speed)%dots.size()]

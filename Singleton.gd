extends Node

var score_label
var score = 0

var high_score = 0
var prev_high_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if score_label:
		score_label.text = str(score)
	
	if score>high_score:
		high_score=score
	pass

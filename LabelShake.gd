extends Label

export var decay = .8  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(7, 7)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
export (NodePath) var target  # Assign the node this camera will follow.

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
onready var noise = OpenSimplexNoise.new()
var noise_y = 0

func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func _process(delta):
	rect_position = Vector2(0,0)
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
	if Input.is_action_just_pressed("ui_down"):
		add_trauma(.7)
		
func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	# Using noise
	#rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	rect_position.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	rect_position.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
	if abs(rect_position.x)<1:
		rect_position.x = 0
	if abs(rect_position.y)<1:
		rect_position.y = 0
	
func add_trauma(amount):
	$Coin.play()
	trauma = min(trauma + amount, 1.0)
	

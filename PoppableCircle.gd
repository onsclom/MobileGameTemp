extends Node2D

onready var vis_rect1 = $Rect1
onready var vis_rect2 = $Rect2
onready var vis_rect3 = $Rect3


export(Color, RGB) var good_color1
export(Color, RGB) var good_color2
export(Color, RGB) var bad_color1
export(Color, RGB) var bad_color2

var rotation_speed = 100
export(bool) var good = true

signal popped

var particles = preload("res://PoppedParticles.tscn")
var plus1 = preload("res://plus1.tscn")
var texture

var time_alive = 0

var sprout_speed = 3

func _ready():
	scale.x = time_alive
	scale.y = time_alive
#	if good:
#		vis_rect1.modulate=good_color1
#		vis_rect2.modulate=good_color2
#		vis_rect3.modulate=good_color1
#	else:
#		vis_rect1.modulate=bad_color1
#		vis_rect2.modulate=bad_color2
#		vis_rect3.modulate=bad_color1
		
	$Rect3.material.set_shader_param("pattern", texture)
	$Rect2.material.set_shader_param("pattern", texture)
	$Rect1.material.set_shader_param("pattern", texture)

func _process(delta):
	time_alive += delta*sprout_speed
	time_alive = min(1, time_alive)
	scale.x = time_alive
	scale.y = time_alive
	vis_rect1.rect_rotation += delta*rotation_speed
	vis_rect2.rect_rotation += delta*rotation_speed/.8
	vis_rect3.rect_rotation += delta*rotation_speed/.6
	$Rect4.rect_rotation = $Rect1.rect_rotation
	$Rect5.rect_rotation = $Rect2.rect_rotation
	$Rect6.rect_rotation = $Rect3.rect_rotation
	
func _pop():
	var new_particles = particles.instance()
	new_particles.position = position
	get_parent().add_child(new_particles)
	new_particles.emitting= true
	new_particles.scale.x = self.scale.x
	new_particles.scale.y = self.scale.y
	emit_signal("popped")
	
	var new_plus1 = plus1.instance()
	new_plus1.position = position
	get_parent().add_child(new_plus1)
	new_plus1.target = get_parent().get_node("Target")
	queue_free()
	
func easeOutBack(x):
	var c1 = 1.70158;
	var c3 = c1 + 1;

	return 1 + c3 * pow(x - 1, 3) + c1 * pow(x - 1, 2);

func _input(event):
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
		if get_local_mouse_position().length() < 40:
			_pop()
#		if get_rect().has_point(get_local_mouse_position()):
#			print('test')
#			get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input

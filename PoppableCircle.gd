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
var texture

func _ready():
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
	vis_rect1.rect_rotation += delta*rotation_speed
	vis_rect2.rect_rotation -= delta*rotation_speed/1.2
	vis_rect3.rect_rotation -= delta*rotation_speed/1.6
	
func _pop():
	var new_particles = particles.instance()
	new_particles.position = position
	get_parent().add_child(new_particles)
	new_particles.emitting= true
	new_particles.scale.x = self.scale.x
	new_particles.scale.y = self.scale.y
	emit_signal("popped")
	queue_free()

func _input(event):
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
		if get_local_mouse_position().length() < 30:
			_pop()
#		if get_rect().has_point(get_local_mouse_position()):
#			print('test')
#			get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input

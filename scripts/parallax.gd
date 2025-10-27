extends Node3D

@export var tilt_strength : float = 0.05
@export var tilt_smoothness : float = 5.0

var target_rotation : Vector3

func _process(delta: float) -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()
	
	var x = ((mouse_position.x / viewport_size.x) - 0.5) * 2.0
	var y = ((mouse_position.y / viewport_size.y) - 0.5) * 2.0
	
	target_rotation.x = y * tilt_strength
	target_rotation.y = x * tilt_strength
	
	rotation = rotation.lerp(target_rotation, delta * tilt_smoothness)

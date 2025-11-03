extends Television

var tv_mesh : MeshInstance3D
var dial_mesh : MeshInstance3D
var highlight_mat = preload("res://materials/parasonic_highlight.tres")
var dial_highlight_mat = preload("res://materials/parasonic_dial_highlight.tres")

@export var rotation_speed : float = 0.5

var dial_hover : bool = false
var is_dragging : bool = false
var dial_angle : float = 0.0
var input_angle : float
var snap_steps : int = 12
var step_angle : float = 360.0 / snap_steps

var last_mouse_x : float = 0.0

func _ready() -> void:
	tv_mesh = $TVMesh
	dial_mesh = $TVMesh/DialArea/Dial
	prepare_video()

func posess(dist : int, positive : bool):
	if not posessed:
		posessed = true
		tune_distance = dist

func highlight(state : bool):
	if state:
		tv_mesh.set_surface_override_material(0, highlight_mat)
		dial_mesh.set_surface_override_material(0, dial_highlight_mat)
	else:
		tv_mesh.set_surface_override_material(0, null)
		dial_mesh.set_surface_override_material(0, null)
		if dial_hover:
			dial_mesh.set_surface_override_material(0, dial_highlight_mat)

func dial_rotate(dir):
	pass

func _on_dial_area_mouse_entered() -> void:
	dial_hover = true

func _on_dial_area_mouse_exited() -> void:
	dial_hover = false

func _on_dial_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_dragging = true
				last_mouse_x = event.position.x

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not event.pressed:
				is_dragging = false

	elif event is InputEventMouseMotion and is_dragging:
		var delta_x = event.position.x - last_mouse_x
		last_mouse_x = event.position.x
		
		input_angle -= delta_x * rotation_speed
		dial_angle = round(input_angle / step_angle) * step_angle
		dial_angle = clamp(dial_angle, -180, 180)
		dial_mesh.rotation_degrees.z = dial_angle

extends Television

var tv_mesh
var highlight_mat = preload("res://materials/yoshiba_highlight.tres")
var button_up_mesh : MeshInstance3D
var button_down_mesh : MeshInstance3D
var button_up : bool
var button_down : bool

func _ready() -> void:
	tv_mesh = $TVMesh
	button_up_mesh = $TVMesh/ButtonUpArea/ButtonUp
	button_down_mesh = $TVMesh/ButtonDownArea/ButtonDown
	prepare_video()

func posess(dist : int, positive : bool):
	if not posessed:
		posessed = true
		if positive:
			tune_distance = dist
		else:
			tune_distance = -dist

func highlight(state : bool):
	if state:
		tv_mesh.set_surface_override_material(0, highlight_mat)
		button_up_mesh.set_surface_override_material(0, highlight_mat)
		button_down_mesh.set_surface_override_material(0, highlight_mat)
	else:
		tv_mesh.set_surface_override_material(0, null)
		if button_up:
			button_up_mesh.set_surface_override_material(0, highlight_mat)
		else:
			button_up_mesh.set_surface_override_material(0, null)
		if button_down:
			button_down_mesh.set_surface_override_material(0, highlight_mat)
		else:
			button_down_mesh.set_surface_override_material(0, null)

func _on_button_up_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		tune_distance += 1

func _on_button_up_area_mouse_entered() -> void:
	button_up = true

func _on_button_up_area_mouse_exited() -> void:
	button_up = false

func _on_button_down_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		tune_distance -= 1

func _on_button_down_area_mouse_entered() -> void:
	button_down = true

func _on_button_down_area_mouse_exited() -> void:
	button_down = false

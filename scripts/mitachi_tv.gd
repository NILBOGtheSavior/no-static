extends Television

var tv_mesh : MeshInstance3D
var highlight_mat = preload("res://materials/mitachi_highlight.tres")

var channel : int

var tune_channel : int

var channel_1_mesh : MeshInstance3D
var channel_2_mesh : MeshInstance3D
var channel_3_mesh : MeshInstance3D
var channel_4_mesh : MeshInstance3D
var channel_5_mesh : MeshInstance3D
var channel_6_mesh : MeshInstance3D
var channel_7_mesh : MeshInstance3D

var channel_1 : bool
var channel_2 : bool
var channel_3 : bool
var channel_4 : bool
var channel_5 : bool
var channel_6 : bool
var channel_7 : bool

func _ready() -> void:
	tv_mesh = $TVMesh
	channel_1_mesh = $TVMesh/Channel1Area/Channel1
	channel_2_mesh = $TVMesh/Channel2Area/Channel2
	channel_3_mesh = $TVMesh/Channel3Area/Channel3
	channel_4_mesh = $TVMesh/Channel4Area/Channel4
	channel_5_mesh = $TVMesh/Channel5Area/Channel5
	channel_6_mesh = $TVMesh/Channel6Area/Channel6
	channel_7_mesh = $TVMesh/Channel7Area/Channel7
	prepare_video()

func posess(dist : int, positive : bool):
	if not posessed:
		posessed = true
		tune_channel = randi_range(1, 7)
		tune_distance = dist

func set_channel(num):
	channel = num
	if channel == tune_channel:
		tune_distance = 0
	else:
		tune_distance = randi_range(3, 8)

func highlight(state : bool):
	if state:
		tv_mesh.set_surface_override_material(0, highlight_mat)
	else:
		tv_mesh.set_surface_override_material(0, null)
		if channel_1:
			channel_1_mesh.set_surface_override_material(0, highlight_mat)
		else:
			channel_1_mesh.set_surface_override_material(0, null)
		if channel_2:
			channel_2_mesh.set_surface_override_material(0, highlight_mat)
		else:
			channel_2_mesh.set_surface_override_material(0, null)
		if channel_3:
			channel_3_mesh.set_surface_override_material(0, highlight_mat)
		else:
			channel_3_mesh.set_surface_override_material(0, null)
		if channel_4:
			channel_4_mesh.set_surface_override_material(0, highlight_mat)
		else:
			channel_4_mesh.set_surface_override_material(0, null)
		if channel_5:
			channel_5_mesh.set_surface_override_material(0, highlight_mat)
		else:
			channel_5_mesh.set_surface_override_material(0, null)
		if channel_6:
			channel_6_mesh.set_surface_override_material(0, highlight_mat)
		else:
			channel_6_mesh.set_surface_override_material(0, null)
		if channel_7:
			channel_7_mesh.set_surface_override_material(0, highlight_mat)
		else:
			channel_7_mesh.set_surface_override_material(0, null)
		
func _on_channel_1_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		set_channel(1)
		
func _on_channel_1_area_mouse_entered() -> void:
	channel_1 = true

func _on_channel_1_area_mouse_exited() -> void:
	channel_1 = false

func _on_channel_2_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		set_channel(2)

func _on_channel_2_area_mouse_entered() -> void:
	channel_2 = true

func _on_channel_2_area_mouse_exited() -> void:
	channel_2 = false

func _on_channel_3_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		set_channel(3)

func _on_channel_3_area_mouse_entered() -> void:
	channel_3 = true

func _on_channel_3_area_mouse_exited() -> void:
	channel_3 = false

func _on_channel_4_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		set_channel(4)

func _on_channel_4_area_mouse_entered() -> void:
	channel_4 = true

func _on_channel_4_area_mouse_exited() -> void:
	channel_4 = false

func _on_channel_5_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		set_channel(5)

func _on_channel_5_area_mouse_entered() -> void:
	channel_5 = true

func _on_channel_5_area_mouse_exited() -> void:
	channel_5 = false

func _on_channel_6_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		set_channel(6)

func _on_channel_6_area_mouse_entered() -> void:
	channel_6 = true

func _on_channel_6_area_mouse_exited() -> void:
	channel_6 = false

func _on_channel_7_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		set_channel(7)

func _on_channel_7_area_mouse_entered() -> void:
	channel_7 = true

func _on_channel_7_area_mouse_exited() -> void:
	channel_7 = false

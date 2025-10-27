extends StaticBody3D

var tv_mesh
var screen_mesh
var video_player
var movie_audio_player : AudioStreamPlayer3D
var static_audio_player : AudioStreamPlayer3D
var highlight_mat = preload("res://materials/yoshiba_highlight.tres")
var screen_mat
var screen_shader
var button_up_mesh
var button_down_mesh
var button_up : bool
var button_down : bool

@export var score : int = 5

@export_range(0,1) var noise_strength : float = 0

var posessed : bool = false
var tune_distance : int = 0

func _ready() -> void:
	tv_mesh = $CollisionShape3D/yoshiba_tv/TV
	screen_mesh = $CollisionShape3D/yoshiba_tv/Screen
	button_up_mesh = $CollisionShape3D/yoshiba_tv/ButtonUp
	button_down_mesh = $CollisionShape3D/yoshiba_tv/ButtonDown
	video_player = $CollisionShape3D/yoshiba_tv/MeshInstance3D/SubViewport/VideoStreamPlayer
	movie_audio_player = $CollisionShape3D/yoshiba_tv/MovieAudio
	static_audio_player = $CollisionShape3D/yoshiba_tv/StaticAudio
	screen_mat = $CollisionShape3D/yoshiba_tv/MeshInstance3D.get_surface_override_material(0)
	screen_shader = screen_mat.get_shader()
	var length = video_player.get_stream_length()
	var start_position = randf() * length
	video_player.stream_position = start_position
	video_player.play()
	movie_audio_player.play(start_position)
	static_audio_player.volume_db = -80
	static_audio_player.play()

func _process(delta: float) -> void:
	noise_strength = lerp(noise_strength, abs(tune_distance) / 10.0, delta * 5)
	screen_mat.set_shader_parameter("noise_strength", noise_strength)
	update_audio()
	if tune_distance == 0 and posessed == true:
		GameManager.add_score(score)
		posessed = false
	if tune_distance > 10:
		tune_distance = 10
	if tune_distance < - 10:
		tune_distance = -10
	if self == GameManager.selected_object:
		highlight(true)
	else:
		highlight(false)

func update_audio():
	# audio from -80 to -25
	var movie_db_value = lerp(-5, -80, noise_strength)
	var static_db_value = lerp(-80, -25, noise_strength)
	static_audio_player.volume_db = static_db_value
	movie_audio_player.volume_db = movie_db_value

func posess(dist : int, positive : bool):
	if not posessed:
		posessed = true
		if positive:
			tune_distance = dist
		else:
			tune_distance = -dist

func get_marker():
	return $Marker3D

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

func _on_button_down_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		tune_distance -= 1

func _on_button_up_area_mouse_entered() -> void:
	button_up = true

func _on_button_up_area_mouse_exited() -> void:
	button_up = false


func _on_button_down_area_mouse_entered() -> void:
	button_down = true


func _on_button_down_area_mouse_exited() -> void:
	button_down = false

extends StaticBody3D

var tv_mesh
var screen_mesh
var video_player
var movie_audio_player : AudioStreamPlayer3D
var static_audio_player : AudioStreamPlayer3D
var highlight_mat = preload("res://materials/yoshiba_highlight.tres")
var screen_mat
var screen_shader

@export_range(0,1) var noise_strength : float = 0

func _ready() -> void:
	tv_mesh = $CollisionShape3D/yoshiba_tv/TV
	screen_mesh = $CollisionShape3D/yoshiba_tv/Screen
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
	static_audio_player.play()

func _process(delta: float) -> void:
	screen_mat.set_shader_parameter("noise_strength", noise_strength)
	update_audio()
	if self == GameManager.selected_object:
		highlight(true)
	else:
		highlight(false)

func update_audio():
	# audio from -80 to -25
	var min_db = -80
	var max_db = -5
	var movie_db_value = lerp(max_db, min_db, noise_strength)
	var static_db_value = lerp(min_db, max_db, noise_strength)
	static_audio_player.volume_db = static_db_value
	movie_audio_player.volume_db = movie_db_value

func start_static():
	noise_strength = 0.5

func get_marker():
	return $Marker3D

func highlight(state : bool):
	if state:
		tv_mesh.set_surface_override_material(0, highlight_mat)
	else:
		tv_mesh.set_surface_override_material(0, null)

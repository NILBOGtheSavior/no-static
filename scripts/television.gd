extends StaticBody3D
class_name Television

@export var screen_mesh : MeshInstance3D
@export var video_player : VideoStreamPlayer
@export var movie_audio_player : AudioStreamPlayer3D
@export var static_audio_player : AudioStreamPlayer3D

var screen_mat
var screen_shader

@export var score : int = 5

var noise_strength : float = 0
var posessed : bool = false

var tune_distance : int = 0

func _ready() -> void:
	#screen_mesh = $Video
	#video_player = $Video/SubViewport/VideoStreamPlayer
	#movie_audio_player = $MovieAudio
	#static_audio_player = $StaticAudio
	pass
	

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

func prepare_video():
	screen_mat = screen_mesh.get_surface_override_material(0)
	screen_shader = screen_mat.get_shader()
	var length = video_player.get_stream_length()
	var start_position = randf() * length
	video_player.stream_position = start_position
	video_player.play()
	movie_audio_player.play(start_position)
	static_audio_player.volume_db = -80
	static_audio_player.play()

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
	pass

extends Node3D

func _ready():
	var audio = $StaticAudio
	audio.volume_db = -80
	audio.play()

	var tween = create_tween()
	tween.tween_property(audio, "volume_db", -25.0, 2.0) # fade to 0dB over 2 seconds

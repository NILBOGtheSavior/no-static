extends Node

var MOUSE_SENSITIVITY : float = 0.05
var MASTER_VOLUME: int = 0
var MENU_VOLUME : int = 0
var GAME_VOLUME : int = 0


var score = 0
var health : float
var min_health : float = 10.0
var max_health : float = 5000.0

var min_time = 2.0
var max_time = 10.0
var difficulty_multiplier = 500

var tvs : Array

#var paused : bool
var cursor_enabled : bool

var selected_object
var active_object

func _ready() -> void:
	load_settings()

func _process(delta: float) -> void:
	if cursor_enabled:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func add_score(points):
	score += points

func posess_tv():
	var random_tv = tvs.pick_random()
	#print(random_tv)
	random_tv.posess(randi_range(2, 5), randi_range(0, 1))

func get_timer_duration(score: float) -> float:
	# Linear mapping: higher score → shorter duration
	var a = clamp(score / difficulty_multiplier, 0.0, 1.0)
	var time = lerp(max_time, min_time, pow(a, -0.5))
	#print(time)
	return time

func set_volume():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), MASTER_VOLUME)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Menu"), MENU_VOLUME)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Game"), GAME_VOLUME)

func load_settings():
	var config = ConfigFile.new()
	
	var err = config.load("user://data.cfg")
	
	if err == OK:
		MOUSE_SENSITIVITY = float(config.get_value("Settings", "MOUSE_SENSITIVITY", 0.05))
		MASTER_VOLUME = float(config.get_value("Settings", "MASTER_VOLUME", 0))
		MENU_VOLUME = float(config.get_value("Settings", "MENU_VOLUME", 0))
		GAME_VOLUME = float(config.get_value("Settings", "GAME_VOLUME", 0))
	else:
		print("No settings file found, using defaults.")
		
	set_volume()

func save_settings(key, val):
	var config = ConfigFile.new()
	
	config.set_value("Settings", key, val)
	
	config.save("user://data.cfg")

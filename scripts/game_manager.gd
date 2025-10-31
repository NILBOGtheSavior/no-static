extends Node

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

func add_score(points):
	score += points

func _process(delta: float) -> void:
	if cursor_enabled:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func posess_tv():
	var random_tv = tvs.pick_random()
	#print(random_tv)
	random_tv.posess(randi_range(2, 5), randi_range(0, 1))

func get_timer_duration(score: float) -> float:
	# Linear mapping: higher score → shorter duration
	var a = clamp(score / difficulty_multiplier, 0.0, 1.0)
	var time = lerp(max_time, min_time, pow(a, -0.5))
	print(time)
	return time
	
	
	

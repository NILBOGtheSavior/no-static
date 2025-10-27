extends Node

var score = 0
var health : float
var min_health : float = 10.0
var max_health : float = 25.0

var min_time = 2.0
var max_time = 10.0
var max_score = 150

var tvs : Array

var selected_object = null
var active_object = null

func add_score(points):
	score += points

func posess_tv():
	var random_tv = tvs.pick_random()
	print(random_tv)
	random_tv.posess(randi_range(2, 5), randi_range(0, 1))

func get_timer_duration(score: float) -> float:
	# Linear mapping: higher score → shorter duration
	var t = clamp(score / max_score, 0.0, 1.0)
	return lerp(max_time, min_time, t)

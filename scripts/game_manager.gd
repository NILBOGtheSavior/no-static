extends Node

var score = 0

var tvs : Array

var selected_object = null
var active_object = null

func _ready() -> void:
	tvs = get_tree().get_nodes_in_group("tv_objects")
	var random_tv = tvs.pick_random()
	print(random_tv)
	random_tv.start_static()

func add_score(points):
	score += points
	

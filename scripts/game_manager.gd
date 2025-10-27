extends Node

var score = 0

var tvs : Array

var selected_object = null
var active_object = null

func add_score(points):
	score += points

func posess_tv():
	var random_tv = tvs.pick_random()
	print(random_tv)
	random_tv.posess(randi_range(2, 5), randi_range(0, 1))

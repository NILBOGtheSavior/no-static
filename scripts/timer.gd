extends Timer

var health : int

func _ready() -> void:
	GameManager.tvs = get_tree().get_nodes_in_group("tv_objects")
	self.start(5)

func _on_timeout() -> void:
	GameManager.posess_tv()
	health = 0
	for tv in GameManager.tvs:
		health += abs(tv.tune_distance)
		if tv.tune_distance > 0:
			tv.tune_distance += 1
		if tv.tune_distance < 0:
			tv.tune_distance -= 1
	print(health)
	self.start(10)

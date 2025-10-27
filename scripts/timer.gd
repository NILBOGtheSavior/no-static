extends Timer



func _ready() -> void:
	GameManager.tvs = get_tree().get_nodes_in_group("tv_objects")
	self.start(5)

func _process(delta: float) -> void:
	check_health()

func _on_timeout() -> void:
	GameManager.posess_tv()
	for tv in GameManager.tvs:
		if tv.tune_distance > 0:
			tv.tune_distance += 1
		if tv.tune_distance < 0:
			tv.tune_distance -= 1
	self.start(GameManager.get_timer_duration(GameManager.score))



func check_health():
	var health = 0
	for tv in GameManager.tvs:
		health += abs(tv.tune_distance)
	GameManager.health = health

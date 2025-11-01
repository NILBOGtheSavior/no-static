extends Node

var pause_menu_scene = preload("res://gui/pause_menu_gui.tscn")
var pause_menu

func _ready() -> void:
	GameManager.cursor_enabled = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not pause_menu:
			pause_game()
		else:
			_on_resume_game()

func _on_resume_game():
	get_tree().paused = false
	pause_menu.queue_free()
	pause_menu = null

func _on_game_over():
	var current_scene = get_tree().current_scene
	current_scene.queue_free()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func _on_restart_game():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_main_menu():
	var current_scene = get_tree().current_scene
	current_scene.queue_free()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func pause_game():
	pause_menu = pause_menu_scene.instantiate()
	add_child(pause_menu)
	pause_menu.resume_game.connect(_on_resume_game)
	pause_menu.restart_game.connect(_on_restart_game)
	pause_menu.main_menu.connect(_on_main_menu)
	get_tree().paused = true
	

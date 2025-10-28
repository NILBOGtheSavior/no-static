extends Node

var score : Label

func _ready() -> void:
	score = $VBoxContainer/HBoxContainer/Score
	score.text = str(GameManager.score)
	GameManager.cursor_enabled = true
	
func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

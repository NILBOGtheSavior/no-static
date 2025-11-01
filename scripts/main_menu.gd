extends Control

func _ready() -> void:
	GameManager.cursor_enabled = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

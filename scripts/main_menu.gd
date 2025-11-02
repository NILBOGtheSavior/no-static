extends Control

var settings_menu_scene = preload("res://gui/settings_menu_gui.tscn")
var settings_menu

func _ready() -> void:
	GameManager.cursor_enabled = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	settings_menu = settings_menu_scene.instantiate()
	add_child(settings_menu)

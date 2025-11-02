extends Control

var settings_menu_scene = preload("res://gui/settings_menu_gui.tscn")
var settings_menu

signal resume_game
signal restart_game
signal main_menu

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_resume_pressed():
	queue_free()
	emit_signal("resume_game")
	
func _on_restart_pressed() -> void:
	emit_signal("restart_game")
	
func _on_settings_pressed() -> void:
	settings_menu = settings_menu_scene.instantiate()
	add_child(settings_menu)

func _on_quit_pressed():
	get_tree().quit()

func _on_quit_to_menu_pressed() -> void:
	emit_signal("main_menu")

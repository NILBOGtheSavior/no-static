extends Control

signal resume_game
signal restart_game
signal main_menu

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _on_resume_pressed():
	emit_signal("resume_game")

func _on_quit_pressed():
	get_tree().quit()

func _on_quit_to_menu_pressed() -> void:
	emit_signal("main_menu")

func _on_restart_pressed() -> void:
	emit_signal("restart_game")

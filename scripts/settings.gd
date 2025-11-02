extends Control

func _ready() -> void:
	$MenuContainer/MouseSensitivitySlider.value = GameManager.MOUSE_SENSITIVITY
	$MenuContainer/MasterVolumeSlider.value = inverse_lerp(-40, 0, GameManager.MASTER_VOLUME) * 100.0
	$MenuContainer/MenuVolumeSlider.value = inverse_lerp(-40, 0, GameManager.MENU_VOLUME) * 100.0
	$MenuContainer/GameVolumeSlider.value = inverse_lerp(-40, 0, GameManager.GAME_VOLUME) * 100.0

func _on_back_button_pressed() -> void:
	queue_free()

func _on_mouse_sensitivity_slider_value_changed(value: float) -> void:
	GameManager.MOUSE_SENSITIVITY = value
	GameManager.save_settings("MOUSE_SENSITIVITY", value)

func _on_master_volume_slider_value_changed(value: float) -> void:
	var volume = lerp(-40, 0, value / 100.0)
	GameManager.MASTER_VOLUME = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)
	GameManager.save_settings("MASTER_VOLUME", volume)

func _on_menu_volume_slider_value_changed(value: float) -> void:
	var volume = lerp(-40, 0, value / 100.0)
	GameManager.MENU_VOLUME = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Menu"), volume)
	GameManager.save_settings("MENU_VOLUME", volume)

func _on_game_volume_slider_value_changed(value: float) -> void:
	var volume = lerp(-40, 0, value / 100.0)
	GameManager.GAME_VOLUME = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Game"), volume)
	GameManager.save_settings("GAME_VOLUME", volume)

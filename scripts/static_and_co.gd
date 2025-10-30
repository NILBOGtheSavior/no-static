extends Node3D

class LightUnit:
	var material : StandardMaterial3D
	var light : OmniLight3D
	var timer : Timer
	
	func _init(t) -> void:
		timer = t
		timer.timeout.connect(_on_flicker)
		timer.start(randf_range(5.0, 10.0))
	
	func _on_flicker():
		material.emission_energy_multiplier = 0.0
		light.light_energy = 0.0

var light1 : LightUnit
var light2 : LightUnit

func _ready() -> void:
	prepare_lights()
	
func prepare_lights():
	light1 = LightUnit.new($Timer)
	light1.material = $LightPanel.get_surface_override_material(1)
	light1.light = $LightPanelOmni
	
	light2 = LightUnit.new($Timer001)
	light2.material = $LightPanel_001.get_surface_override_material(1)
	light2.light = $LightPanel_001Omni

extends Node3D

class LightUnit:
	var emission : float
	var energy : float

var light1 : LightUnit
var light2 : LightUnit

func _ready() -> void:
	prepare_lights()
	
func prepare_lights():
	light1 = LightUnit.new()
	light1.emission = $LightPanel.get_surface_override_material(1).emission_energy_multiplier
	light1.energy = $LightPanelOmni.light_energy
	
	light2 = LightUnit.new()
	light2.emission = $LightPanel_001.get_surface_override_material(1).emission_energy_multiplier
	light2.energy = $LightPanel_001Omni.light_energy

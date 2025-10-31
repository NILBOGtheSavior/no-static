extends Node3D
class_name StaticCo

var light1 : LightUnit
var light2 : LightUnit

func _ready() -> void:
	prepare_lights()

func prepare_lights():
	light1 = LightUnit.new($LightPanel1/Timer)
	light1.material = $LightPanel1/Mesh.get_surface_override_material(1)
	light1.light = $LightPanel1
	
	light2 = LightUnit.new($LightPanel2/Timer)
	light2.material = $LightPanel2/Mesh.get_surface_override_material(1)
	light2.light = $LightPanel2

class LightUnit:
	var material : StandardMaterial3D
	var light : OmniLight3D
		
	var timer : Timer
	var flicker_cycles : int
	
	func _init(t : Timer) -> void:
		timer = t
		timer.timeout.connect(flicker_cycle)
		flicker()
		
	func flicker():
		flicker_cycles = randi_range(5, 15)
		timer.start(randf_range(1.0, 5.0))
	
	func flicker_cycle():
		if flicker_cycles:
			flicker_cycles -= 1
			var energy = randf()
			material.emission_energy_multiplier = energy
			light.light_energy = energy * 0.1
			timer.start(randf_range(0.05, 0.1))
		else:
			material.emission_energy_multiplier = 1
			light.light_energy = 0.1
			flicker()
			

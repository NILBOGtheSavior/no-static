extends Node3D

var timer : Timer
var flicker_cycles : int

var neon_blue : MeshInstance3D
var neon_red : MeshInstance3D

var neon_blue_mat : StandardMaterial3D
var neon_red_mat : StandardMaterial3D

func _ready() -> void:
	neon_blue = $NeonBlue
	neon_red = $NeonRed
	neon_blue_mat = neon_blue.get_active_material(0)
	neon_red_mat = neon_red.get_active_material(0)
	timer = $Timer
	timer.timeout.connect(flicker_cycle)
	flicker()
		
func flicker():
	flicker_cycles = randi_range(5, 15)
	timer.start(randf_range(0, 2.0))
	
func flicker_cycle():
	if flicker_cycles:
		flicker_cycles -= 1
		var energy = randf()
		neon_blue_mat.emission_energy_multiplier = energy * 16.0
		neon_red_mat.emission_energy_multiplier = energy * 16.0
		timer.start(randf_range(0.05, 0.1))
	else:
		neon_blue_mat.emission_energy_multiplier = 16.0
		neon_red_mat.emission_energy_multiplier = 16.0
		flicker()

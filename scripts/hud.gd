extends Control

var noise : ColorRect
@export_range(0,1) var noise_strength : float

var label : Label
var ihint : Label
var lhint : Label

func _ready() -> void:
	label = $Score
	ihint = $InteractHint
	lhint = $LeaveHint
	noise = $ColorRect
	

func _process(delta: float) -> void:
	label.text = str(GameManager.score)
	
	noise_strength = clamp((GameManager.health - GameManager.min_health) / (GameManager.max_health -  GameManager.min_health), 0.0, 1.0)
	noise.material.set_shader_parameter("noise_strength", noise_strength)
	
	ihint.visible = GameManager.selected_object != null
	lhint.visible = GameManager.active_object != null

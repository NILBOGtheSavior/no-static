extends Television

var tv_mesh
var highlight_mat = preload("res://materials/mitachi_highlight.tres")

func _ready() -> void:
	tv_mesh = $TVMesh
	prepare_video()

func highlight(state : bool):
	if state:
		tv_mesh.set_surface_override_material(0, highlight_mat)
	else:
		tv_mesh.set_surface_override_material(0, null)

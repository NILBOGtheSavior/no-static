extends CharacterBody3D

@export var walking_speed : int = 5
@export var running_speed : int = 10
@export var friction : int = 5

var pause_menu_scene = preload("res://scenes/pause_menu.tscn")
var pause_menu

var target_velocity = Vector3.ZERO
var dir = Vector3()

var camera
var rotation_helper
var raycast

var allow_movement : bool = true

var MOUSE_SENSITIVITY : float = 0.05

func _ready() -> void:
	camera = $RotationHelper/Camera3D
	rotation_helper = $RotationHelper
	raycast = $RotationHelper/Camera3D/RayCast3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta: float) -> void:
	#print(GameManager.health)
	if GameManager.health > GameManager.max_health:
		game_over()
	if allow_movement:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if raycast.is_colliding() and GameManager.active_object == null:
		var obj = raycast.get_collider()
		if obj.is_in_group("tv_objects"):
			GameManager.selected_object = obj
	else:
		GameManager.selected_object = null
		
	if Input.is_action_just_pressed("select_item") and GameManager.active_object != null:
		GameManager.active_object = null
		reset_camera()
		
	if Input.is_action_just_pressed("select_item") and GameManager.selected_object != null:
		GameManager.active_object = GameManager.selected_object
		tune_tv(delta)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not pause_menu:
			pause_game()
			
	if GameManager.active_object == null:
		handle_movement(delta)
	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and GameManager.active_object == null:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		
		var camera_rotation = rotation_helper.rotation_degrees
		camera_rotation.x = clamp(camera_rotation.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rotation

func handle_movement(delta):
	dir = Vector3.ZERO
	
	var cam_xform = camera.get_global_transform()
	
	var input_movement_vector = Vector2()
	
	if Input.is_action_pressed("move_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_movement_vector.x += 1
	if Input.is_action_pressed("move_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("move_backward"):
		input_movement_vector.y -= 1
		
	input_movement_vector = input_movement_vector.normalized()
	
	dir += -cam_xform.basis.z.normalized() * input_movement_vector.y
	dir += cam_xform.basis.x.normalized() * input_movement_vector.x
		
	target_velocity.x = dir.x * walking_speed
	target_velocity.z = dir.z * walking_speed
	
	velocity = lerp(velocity, target_velocity, delta * friction)

func game_over():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var current_scene = get_tree().current_scene
	current_scene.queue_free()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func pause_game():
	pause_menu = pause_menu_scene.instantiate()
	add_child(pause_menu)
	pause_menu.resume_game.connect(_on_resume_game)
	pause_menu.restart_game.connect(_on_restart_game)
	pause_menu.main_menu.connect(_on_main_menu)
	get_tree().paused = true
	toggle_cursor()

func _on_resume_game():
	get_tree().paused = false
	pause_menu.queue_free()
	pause_menu = null
	
func _on_restart_game():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_main_menu():
	var current_scene = get_tree().current_scene
	current_scene.queue_free()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func toggle_cursor():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func reset_camera():
	var camera_target = $RotationHelper/Marker3D
	camera.global_position = camera_target.global_position
	camera.global_rotation = camera_target.global_rotation
	allow_movement = true

func tune_tv(delta):
	velocity = Vector3.ZERO
	GameManager.selected_object = null
	var camera_target = GameManager.active_object.get_marker()
	camera.global_position = camera_target.global_position
	camera.global_rotation = camera_target.global_rotation
	allow_movement = false

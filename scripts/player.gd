extends CharacterBody3D

@export var walking_speed : int = 5
@export var running_speed : int = 10
@export var friction : int = 5

signal game_over

var target_velocity = Vector3.ZERO
var dir = Vector3()

var camera
var rotation_helper
var raycast

var allow_movement : bool = true

func _ready() -> void:
	camera = $RotationHelper/Camera3D
	rotation_helper = $RotationHelper
	raycast = $RotationHelper/Camera3D/RayCast3D
	GameManager.cursor_enabled = false
	
func _process(delta: float) -> void:
	#print(GameManager.health)
	if GameManager.health > GameManager.max_health:
		allow_movement = false
		emit_signal("game_over")
		
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
	if GameManager.active_object == null:
		GameManager.cursor_enabled = false
		handle_movement(delta)
	else:
		GameManager.cursor_enabled = true
	
	
func _input(event):
	if event is InputEventMouseMotion and GameManager.cursor_enabled == false and GameManager.active_object == null:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * GameManager.MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * GameManager.MOUSE_SENSITIVITY * -1))
		
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
	move_and_slide()


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

extends RigidDynamicBody3D

@export var acceleration = 1.2
@export var jump_velocity = 150.0
@export var speed = 900.0
@export var max_speed = 900.0
@export var view_sensitivity = 10.0
@export var max_pick_weight = 90.0
@export_range(0.001,1.0) var stop_speed = 0.01

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity = Vector3()
var mouse_input = Vector2()
var is_on_floor = false
var move_input = Vector2()

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var feet := $Feet
@onready var body := $CollisionShape

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg2rad(-50), deg2rad(80))
			mouse_input = event.relative
			
func _ready():
	linear_damp = 1.0
	
func _integrate_forces(state):
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
		
	if move_input.length() < 0.2:
		state.linear_velocity.x = lerp(state.linear_velocity.x, 0.0, stop_speed * mass)
		state.linear_velocity.z = lerp(state.linear_velocity.z, 0.0, stop_speed * mass)
		
	if state.get_contact_count() > 0 and move_input.length() < 0.2:
		if is_on_floor and state.get_contact_local_normal(0).y < 0.9:
			apply_central_force(-state.get_contact_local_normal(0) * 10)

func _physics_process(delta):
	if physics_material_override.friction >= 0:
		physics_material_override.friction = 0
	move_input = Vector2.ZERO
	var direction = Vector3()
	move_input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	direction = (neck.transform.basis * Vector3(move_input.x, 0, move_input.y)).normalized()
	velocity = lerp(velocity, direction * speed, acceleration * mass * delta)
	apply_central_force(velocity)
	
	if feet.is_colliding():
		is_on_floor = true
		physics_material_override.friction = 0.1
		
	if Input.is_action_just_pressed("jump") and is_on_floor:
		is_on_floor = false
		print("jumping")
		apply_central_impulse(Vector3.UP * jump_velocity * mass)


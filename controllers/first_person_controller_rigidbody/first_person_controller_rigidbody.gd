extends RigidDynamicBody3D

@export var acceleration = 1.2
@export var jump_velocity = 110.0
@export var speed = 900.0
@export var max_speed = 900.0
@export var view_sensitivity = 10.0
@export var max_pick_weight = 50.0
@export var pick_strength = 0.1
@export_range(0.001,1.0) var stop_speed = 0.01

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity = Vector3()
var mouse_input = Vector2()
var is_on_floor = false
var move_input = Vector2()
var held_object: Object = null
var ray_object: Object = null

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var feet := $Feet
@onready var body := $CollisionShape
@onready var pick_ray := $Neck/Camera3D/PickRay
@onready var hold_position := $Neck/Camera3D/HoldPosition

func _process(delta):
	ray_object = pick_ray.get_collider()

func _input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg2rad(-50), deg2rad(80))
			mouse_input = event.relative
	if Input.is_action_just_pressed("grab_object"):
		if held_object:
			drop_object()
		else:
			grab_object()
	if Input.is_action_just_pressed("interact"):
		if held_object == null and ray_object:
			interact()
	
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
		apply_central_impulse(Vector3.UP * jump_velocity * mass)
		
	if held_object != null:
		held_object.set_linear_velocity((hold_position.global_transform.origin - held_object.global_transform.origin) * pick_strength * max_pick_weight)

func grab_object():
	var collider = pick_ray.get_collider()
	if ray_object != null and ray_object.is_in_group("Pickable") and ray_object.mass <= max_pick_weight:
		held_object = ray_object

func drop_object():
	held_object = null

func interact():
	if ray_object.is_in_group("Interactable"):
		ray_object.interact()
	

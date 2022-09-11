extends BaseIntelligentEntity3D
class_name PlayerEntity3D

@export var known_locations : Array[Resource] = []

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var body := $CollisionShape
@onready var pick_ray := $Neck/Camera3D/PickRay
@onready var hold_position := $Neck/Camera3D/HoldPosition


var mouse_input = Vector2()
var move_input = Vector2()
var held_object: Object = null
var ray_object: Object = null
var ray_object_old: Object = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ray_object = pick_ray.get_collider()
	if ray_object != ray_object_old:
		ray_object_old = ray_object
		
func _input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-70), deg_to_rad(80))
			mouse_input = event.relative
	if Input.is_action_just_pressed("grab_object"):
		if held_object:
			drop_object()
		else:
			grab_object()
	if Input.is_action_just_pressed("interact"):
		if held_object == null and ray_object:
			interact()
			
func _physics_process(delta):
#	if physics_material_override.friction >= 0:
#		physics_material_override.friction = 0
	move_input = Vector2.ZERO
	var direction = Vector3()
	move_input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	direction = (neck.transform.basis * Vector3(move_input.x, 0, move_input.y)).normalized()
	velocity = lerp(velocity, direction * speed, acceleration * mass * delta)
	apply_central_force(velocity)
	
	if foot_collider.get_overlapping_bodies().size() > 0:
		is_on_floor = true
	else:
		is_on_floor = false
	
	if Input.is_action_just_pressed("jump") and is_on_floor:
		jump()
		
	if held_object != null:
		held_object.set_linear_velocity((hold_position.global_transform.origin - held_object.global_transform.origin) * pick_strength * max_pick_weight)
	
		
func _integrate_forces(state):
	if move_input.length() < 0.2:
		state.linear_velocity.x = lerp(state.linear_velocity.x, 0.0, stop_speed * mass)
		state.linear_velocity.z = lerp(state.linear_velocity.z, 0.0, stop_speed * mass)

	if state.get_contact_count() > 0 and move_input.length() < 0.2:
		if is_on_floor and state.get_contact_local_normal(0).y < 0.9:
			apply_central_force(-state.get_contact_local_normal(0) * 10)


func grab_object():
	var collider = pick_ray.get_collider()
	if ray_object != null and ray_object is BaseDynamicObject3D and ray_object.mass <= max_pick_weight:
		held_object = ray_object

func drop_object():
	held_object = null
	
func interact():
	if ray_object.is_in_group("Interactable"):
		pass
#		var act = ray_object.interact()
#		if act != null:
#			if act[0] == "Armour":
#				model.equip_object(ray_object, act[1])

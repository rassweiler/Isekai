extends RigidBody3D
class_name BaseDynamicEntity3D

@export_node_path(Node3D) var model
@export_node_path(CollisionShape3D) var main_collider
#@export_node_path(RayCast3D,CollisionShape3D) var foot_collider
@export var entity_name : String = "BaseEntity"
@export var acceleration = 1.0
@export_range(0.001,1.0) var stop_speed = 0.015
@export var jump_velocity = 8
@export var view_sensitivity = 10.0
@export var max_pick_weight = 50.0
@export var pick_strength = 0.1
@export var speed = 920.0
@export var max_speed = 1000.0
@export var strength = 100.0
@export var max_strength = 100.0
@export var health = 100.0
@export var max_health = 100.0
@export var stamina = 100.0
@export var max_stamina = 100.0
@export var hunger = 100.0
@export var max_hunger = 100.0
@export var thirst = 100.0
@export var max_thirst = 100.0

@onready var foot_collider : Area3D = $FootArea

var is_on_floor = false
var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass
	
func _integrate_forces(state):
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed

func init_entity():
	pass
	
func sub_process(delta):
	pass

func sub_physics(delta):
	pass
	
func sub_integrate(state):
	pass

func jump():
	is_on_floor = false
	apply_central_impulse(Vector3.UP * jump_velocity * mass)

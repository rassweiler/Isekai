extends RigidBody3D
class_name BaseDynamicEntity3D

@export var mesh : Mesh = preload("res://assets/meshes/base_dynamic_entity_3d_mesh.tres")
@export var collision_shape : Shape3D = preload("res://assets/collision_shapes/base_dynamic_entity_3d_collision_shape.tres")
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

#Copy to higher inheritance
@export_category("Mounting")
@export_node_path(Node3D) var head_mount_location
@export_node_path(Node3D) var chest_mount_location
@export_node_path(Node3D) var hand_r_mount_location
@export_node_path(Node3D) var hand_l_mount_location
@export_node_path(Node3D) var back_mount_location
@export_node_path(Node3D) var waist_mount_location
@export_node_path(Node3D) var legs_mount_location
@export_node_path(Node3D) var foot_r_mount_location
@export_node_path(Node3D) var foot_l_mount_location

@onready var mesh_instance := $MeshInstance3d
@onready var shape_instance := $CollisionShape3d
@onready var foot_ray := $FootRay

var head_mount_item : BaseEquipmentObject3D = null
var chest_mount_item : BaseEquipmentObject3D = null
var hand_r_mount_item : BaseEquipmentObject3D = null
var hand_l_mount_item : BaseEquipmentObject3D = null
var back_mount_item : BaseEquipmentObject3D = null
var waist_mount_litem : BaseEquipmentObject3D = null
var legs_mount_item : BaseEquipmentObject3D = null
var foot_r_mount_item : BaseEquipmentObject3D = null
var foot_l_mount_item : BaseEquipmentObject3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Init():
	pass

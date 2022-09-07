extends StaticBody3D

class_name BaseStaticObject3D

enum object_types {Building,Equipment,Flora}

@export var icon : CompressedTexture2D = preload("res://assets/textures/objects_default.tres")
@export var object_name : String = "BaseObject"
@export var mesh : Mesh = preload("res://assets/meshes/base_static_object_3d_mesh.tres")
@export var collision_shape : Shape3D = preload("res://assets/collision_shapes/base_static_object_3d_collision_shape.tres")
@export var owner_name : String = ""
@export var object_type: object_types = object_types.Building
@export var max_health: int = 100
@export var current_health: int = 100

@onready var mesh_instance := $MeshInstance3d
@onready var shape_instance := $CollisionShape3d

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh_instance.mesh = mesh
	shape_instance.shape = collision_shape

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_object_name() -> String:
	return object_name
	
func set_object_name(new_name: String):
	object_name = new_name
	
func get_owner_name() -> String:
	return owner_name
	
func set_owner_name(new_name: String):
	owner_name = new_name

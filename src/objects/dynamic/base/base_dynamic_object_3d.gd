extends RigidDynamicBody3D
class_name BaseDynamicObject3D

@export_file var icon
@export var object_mass : float
@export var object_name : String = ""
@export var mesh : MeshInstance3D
@export var is_stackable : bool
@export var stack_ammount : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

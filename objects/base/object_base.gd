extends RigidDynamicBody3D

@export var object_name: String = "ObjectBase"

@onready var name_display: Object = $Name

# Called when the node enters the scene tree for the first time.
func _ready():
	name_display.text = object_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_object_name():
	return object_name

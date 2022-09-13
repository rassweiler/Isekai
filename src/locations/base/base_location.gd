extends Node3D
class_name BaseLocation

@export var world_position : Vector3
@export var map_icon_data : Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	position = world_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_map_data() -> MapIconData:
	return map_icon_data
	
func get_global_location() -> Vector3:
	return world_position

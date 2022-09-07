extends MeshInstance3D

@onready var head_location := $HeadLocation
@onready var chest_location := $ChestLocation

var head_item:Object = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func equip_object(object:Object, location:String):
	if object.get_parent():
		object.get_parent().remove_child(object)
		if location == "Head":
			head_location.add_child(object)
			object.set_equipped(true)
	

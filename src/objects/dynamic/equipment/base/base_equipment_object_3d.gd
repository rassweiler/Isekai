extends BaseDynamicObject3D

class_name BaseEquipmentObject3D

enum equip_locations {Head,Chest,HandR,HandL,Back,Waist,Legs,Feet}

@export var equip_location: equip_locations = equip_locations.Head

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func interact():
	return [object_type,equip_location]

func set_equipped(val):
	if val:
		freeze = true
		position = Vector3.ZERO
		shape_instance.disabled = true
	else:
		freeze = false
		shape_instance.disabled = true

extends RigidDynamicBody3D

@export var object_name: String = "EquipmentBase"
@export var object_type: String = "Armour"
@export var equip_location: String = "Head"

@onready var pickup_hint: String = "Pickup " + object_name
@onready var interact_hint: String = "Equip " + object_name
@onready var collider := $CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_object_name():
	return object_name
	
func get_pickup_hint():
	return pickup_hint
	
func get_interact_hint():
	return interact_hint

func interact():
	return [object_type,equip_location]
	
func set_equipped(val):
	if val:
		freeze = true
		position = Vector3.ZERO
		collider.disabled = true
	else:
		freeze = false
		collider.disabled = true

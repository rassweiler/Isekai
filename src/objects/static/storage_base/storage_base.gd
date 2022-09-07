extends AnimatableBody3D

@onready var lid = $Lid
@onready var pickup_hint: String = "Pickup " + object_name
@onready var interact_hint: String = "Open/Close"

@export var object_name: String = "ObjectBase"

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func interact():
	if is_open:
		close()

	else:
		open()
	return null

func toggle_open():
	is_open = !is_open

func open():
	print("open")
	var tween = lid.create_tween()
	tween.tween_property(lid, "rotation",Vector3(deg_to_rad(45),0,0),0.8)
	tween.parallel().tween_property(lid, "position",Vector3(0,1.35,0.156),0.8)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(toggle_open)
	
func close():
	var tween = lid.create_tween()
	tween.tween_property(lid, "rotation",Vector3(deg_to_rad(0),0,0),0.2)
	tween.parallel().tween_property(lid, "position",Vector3(0,1.025,0),0.2)
	tween.tween_callback(toggle_open)

func get_object_name():
	return object_name

func get_pickup_hint():
	return pickup_hint
	
func get_interact_hint():
	return interact_hint
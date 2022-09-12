extends BaseMenu

@export var map_scale : float = 0.25

@onready var close_button: TextureButton = $MarginContainer/NinePatchRect/CloseButton
@onready var icon_container : Node2D = $MarginContainer/NinePatchRect/InnerMargin/Control/Map/Icons
@onready var map : Sprite2D = $MarginContainer/NinePatchRect/InnerMargin/Control/Map

var map_icon := preload("res://ui/menus/map_menu/map_icon/map_icon.tscn")
var known_locations : Array[MapIcon] = []
var player_sprite : MapIcon = null
var player : PlayerEntity3D = null
var map_width : int = 0
var map_height : int = 0
var center : Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	close_button.pressed.connect(close_menu)
	map_width = map.region_rect.size.x
	map_height = map.region_rect.size.y
	center = Vector2(map_width/2,map_height/2)
	reset_map()
	init2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init(player_data : PlayerEntity3D):
	player = player_data
	
func init2():
	if player:
		var sprite = register_location_to_map(player.get_map_icon_data())
		sprite.position = global_to_map(player.position)
		player_sprite = sprite
		for location in player.known_locations:
			known_locations.push_back(register_location_to_map(location.data, global_to_map(location.location)))
	
func global_to_map(val : Vector3) -> Vector2:
	return Vector2(val.x * map_scale,val.z * map_scale)
	
func map_to_global(val : Vector2) -> Vector3:
	return Vector3(0,0,0)

func register_location_to_map(data : MapIconData, position : Vector2 = Vector2.ZERO) -> MapIcon:
	var s = map_icon.instantiate()
	s.init(data)
	icon_container.add_child(s)
	s.position = position
	return s

func reset_map():
	map.position = center
	map.scale = Vector2(1,1)

func pan_map(value : Vector2):
	map.position += value

func _on_control_gui_input(event):
	if event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_MASK_LEFT:
		pan_map(event.relative)

func _on_reset_button_pressed():
	reset_map()

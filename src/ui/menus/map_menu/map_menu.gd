extends BaseMenu

@export var map_scale : float = 0.5

@onready var close_button: TextureButton = $CenterContainer/NinePatchRect/CloseButton
@onready var icon_container : Node2D = $CenterContainer/NinePatchRect/MarginContainer/SubViewportContainer/SubViewport/Icons
@onready var sub_viewport = $CenterContainer/NinePatchRect/MarginContainer/SubViewportContainer/SubViewport

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
	map_width = sub_viewport.size.x
	map_height = sub_viewport.size.y
	center = Vector2(map_width/2,map_height/2)
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
	

func global_to_map(val : Vector3) -> Vector2:
	return Vector2(center.x + val.x * map_scale,center.y + val.z * map_scale)
	
func map_to_global(val : Vector2) -> Vector3:
	return Vector3(0,0,0)

func register_location_to_map(data : MapIconData) -> MapIcon:
	var s = map_icon.instantiate()
	s.init(data)
	icon_container.add_child(s)
	return s

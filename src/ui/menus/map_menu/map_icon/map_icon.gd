extends Node2D
class_name MapIcon

@onready var label = $Label
@onready var icon = $Icon
var _target_transform : RemoteTransform3D = null
var icon_data: MapIconData = null

# Called when the node enters the scene tree for the first time.
func _ready():
	init2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init(new_icon_data: MapIconData, remote_transform: RemoteTransform3D = null):
	icon_data = new_icon_data	
	
func init2():
	icon.scale = icon_data.icon_scale
	icon.modulate = icon_data.colour
	icon.texture = icon_data.texture
	label.modulate = icon_data.colour
	label.text = icon_data.icon_name
	label.scale = icon_data.label_scale

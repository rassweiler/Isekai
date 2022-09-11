extends Sprite2D
class_name MapIcon

@onready var label = $Label
var label_text : String = ""
var _target_transform : RemoteTransform3D = null
var icon_data: MapIconData = null

# Called when the node enters the scene tree for the first time.
func _ready():
	init2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init(icon_data: MapIconData, remote_transform: RemoteTransform3D = null):
	texture = icon_data.texture
	scale = icon_data.scale
	modulate = icon_data.colour
	label_text = icon_data.icon_name
	
func init2():
	label.text = label_text

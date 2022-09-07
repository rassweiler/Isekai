extends Panel

class_name ObjectPanel

@export var default_icon := preload("res://assets/textures/object_panel_generic.tres")
@export var disabled_icon := preload("res://assets/textures/object_panel_disabled.tres")
@export var is_disabled := true

@onready var icon_bg := $MarginContainer/IconBG
@onready var drop_button := $MarginContainer/DropButton
@onready var ammount := $MarginContainer/Ammount

var current_object:RigidBody3D = null
var current_stack_ammount : int = 0
var is_object_stackable : bool = false

func init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	if !current_object:
		drop_button.disabled = true
		if is_disabled:
			icon_bg.set_texture(disabled_icon)
		else:
			icon_bg.set_texture(default_icon)
		ammount.visible = false
	else:
		if is_object_stackable:
			ammount.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Control
class_name FirstPersonUI

@onready var target_name := $TargetName
@onready var pick_hint := $PickHint
@onready var interact_hint := $InteractHint

var is_interaction_visible: bool = false
var mouse_captured: bool = false

func _input(event: InputEvent) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_hints(target, pick, interact):
	#target_name.text = target
	#target_name.visible = true
	pick_hint.text = pick
	pick_hint.visible = true
	interact_hint.text = interact
	interact_hint.visible = true
	
func hide_hints():
	#target_name.visible = false
	pick_hint.visible = false
	interact_hint.visible = false
	
func get_interaction_visible() -> bool:
	return is_interaction_visible

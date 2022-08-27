extends Control

@onready var target_name := $TargetName
@onready var pick_hint := $PickHint
@onready var interact_hint := $InteractHint

var mouse_captured: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse_captured = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			mouse_captured = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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

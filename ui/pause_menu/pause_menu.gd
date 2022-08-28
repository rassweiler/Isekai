extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var resume_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/ResumeButton
@onready var quit_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	resume_button.pressed.connect(unpause)
	quit_button.pressed.connect(get_tree().quit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pause():
	animator.play("Pause")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

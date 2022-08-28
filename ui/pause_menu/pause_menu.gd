extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var resume_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/ResumeButton
@onready var quit_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/QuitButton

signal resume_game_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	resume_button.pressed.connect(close_menu)
	quit_button.pressed.connect(get_tree().quit)
	open_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_menu():
	animator.play("Pause")
	
func close_menu():
	animator.play("Unpause")
	emit_signal("resume_game_signal")

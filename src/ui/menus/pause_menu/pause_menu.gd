extends BaseMenu

@onready var close_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/ResumeButton
@onready var quit_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	close_button.pressed.connect(close_menu)
	quit_button.pressed.connect(get_tree().quit)
	open_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

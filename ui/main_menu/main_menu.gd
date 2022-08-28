extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var new_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/NewButton
@onready var load_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/LoadButton
@onready var settings_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/SettingsButton
@onready var quit_button: Button = $CenterContainer/Panel/MarginContainer/VBoxContainer/QuitButton

signal new_game_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	new_button.pressed.connect(new_game)
	quit_button.pressed.connect(get_tree().quit)
	open_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_menu():
	animator.play("open_menu")
	
func close_menu():
	animator.play("close_menu")

func new_game():
	close_menu()
	emit_signal("new_game_signal") 

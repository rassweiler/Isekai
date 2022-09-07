extends BaseMenu

@onready var close_button := $CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/CloseButton

# Called when the node enters the scene tree for the first time.
func _ready():
	close_button.pressed.connect(close_menu)
	open_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var close_button := $CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/CloseButton

signal close_inventory_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	close_button.pressed.connect(close_menu)
	open_menu()

func init(character=null):
	pass

func open_menu():
	animator.play("Open")
	
func close_menu():
	animator.play("Close")
	emit_signal("close_inventory_signal")

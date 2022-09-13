extends ColorRect
class_name BaseMenu

signal close_menu_signal

@onready var animator: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event: InputEvent) -> void:
	pass
	
func open_menu():
	animator.play("Open")
	
func close_menu():
	animator.play("Close")
	emit_signal("close_menu_signal")

extends BaseMenu
class_name CharacterCreatorMenu

@onready var close_button = $MarginContainer/CloseButton

var player : PlayerEntity3D = null
var direction : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	close_button.pressed.connect(close_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if Input.is_action_pressed("move_left"):
		direction.y -= deg_to_rad(5)
	if Input.is_action_pressed("move_right"):
		direction.y += deg_to_rad(5)
	if player:
		player.rotation.y = lerp(player.rotation.y,direction.y,deg_to_rad(1))

func _input(event: InputEvent) -> void:
	super._input(event)
	
func init(player_target : PlayerEntity3D):
	player = player_target

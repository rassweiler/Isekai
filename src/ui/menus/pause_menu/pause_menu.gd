extends BaseMenu
class_name PauseMenu

signal save_game_signal
signal load_game_signal

@onready var close_button: Button = $CenterContainer/Main/MarginContainer/VBoxContainer/ResumeButton
@onready var quit_button: Button = $CenterContainer/Main/MarginContainer/VBoxContainer/QuitButton
@onready var main := $CenterContainer/Main
@onready var load := $CenterContainer/LoadGame
@onready var load_button : Button = $CenterContainer/LoadGame/MarginContainer/VBoxContainer/ConfirmLoadButton
@onready var back_button : Button = $CenterContainer/LoadGame/MarginContainer/VBoxContainer/BackButton
@onready var item_list : ItemList = $CenterContainer/LoadGame/MarginContainer/VBoxContainer/ScrollContainer/ItemList

var save_list : Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	close_button.pressed.connect(close_menu)
	quit_button.pressed.connect(get_tree().quit)
	open_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	
func init(saves : Array[String]):
	save_list = saves
	for save in save_list:
		item_list.add_item(save)
	
func _on_save_button_pressed():
	emit_signal("save_game_signal")

func _on_load_button_pressed():
	main.visible = false
	load.visible = true

func _on_back_button_pressed():
	main.visible = true
	load.visible = false

extends BaseMenu
class_name MainMenu

signal new_game_signal

@onready var new_button: Button = $CenterContainer/Main/MarginContainer/VBoxContainer/NewButton
@onready var quit_button: Button = $CenterContainer/Main/MarginContainer/VBoxContainer/QuitButton
@onready var main := $CenterContainer/Main
@onready var load := $CenterContainer/LoadGame
@onready var load_button : Button = $CenterContainer/LoadGame/MarginContainer/VBoxContainer/ConfirmLoadButton
@onready var back_button : Button = $CenterContainer/LoadGame/MarginContainer/VBoxContainer/BackButton
@onready var item_list : ItemList = $CenterContainer/LoadGame/MarginContainer/VBoxContainer/ScrollContainer/ItemList

var save_list : Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	new_button.pressed.connect(new_game)
	quit_button.pressed.connect(get_tree().quit)
	open_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func init(saves : Array[String]):
	save_list = saves
	for save in save_list:
		item_list.add_item(save)
	
func new_game():
	close_menu()
	emit_signal("new_game_signal") 

func _on_load_button_pressed():
	main.visible = false
	load.visible = true
	
func _on_back_button_pressed():
	main.visible = true
	load.visible = false

func _on_settings_button_pressed():
	pass

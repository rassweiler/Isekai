extends Node

@onready var menu_list := $Menus

var pause_scene := preload("res://ui/pause_menu/pause_menu.tscn")
var inventory_scene := preload("res://ui/equipment_menu/equipment_menu.tscn")
var menu_scene := preload("res://ui/main_menu/main_menu.tscn")
var main_menu:Node = null
var pause_menu:Node = null
var inventory_menu:Node = null
var is_menu_open := true

# Called when the node enters the scene tree for the first time.
func _ready():
	open_main_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and !is_menu_open:
		open_pause_menu()
	
	if  event.is_action_pressed("open_inventory") and ! is_menu_open:
		open_inventory_menu()
			
func open_main_menu():
	is_menu_open = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	main_menu = menu_scene.instantiate()
	menu_list.add_child(main_menu)
	main_menu.connect("new_game_signal",_on_main_menu_new_game_signal)

func close_main_menu():
	is_menu_open = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	main_menu.queue_free()
	main_menu = null
	
func open_pause_menu():
	is_menu_open = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pause_menu = pause_scene.instantiate()
	menu_list.add_child(pause_menu)
	pause_menu.connect("resume_game_signal",close_pause_menu)

func close_pause_menu():
	is_menu_open = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_menu.queue_free()
	pause_menu = null
	
func open_inventory_menu():
	is_menu_open = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	inventory_menu = inventory_scene.instantiate()
	inventory_menu.init()
	menu_list.add_child(inventory_menu)
	inventory_menu.connect("close_inventory_signal",close_inventory_menu)

func close_inventory_menu():
	is_menu_open = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	inventory_menu.queue_free()
	inventory_menu = null

func _on_main_menu_new_game_signal():
	close_main_menu()

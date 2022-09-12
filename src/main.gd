extends Node

@onready var menu_list := $UI
@onready var player := $Characters/PlayerEntity3D
@onready var e_rantel = $Level/ERantel

var pause_scene := preload("res://ui/menus/pause_menu/pause_menu.tscn")
var inventory_scene := preload("res://ui/menus/inventory_menu/inventory_menu.tscn")
var map_scene := preload("res://ui/menus/map_menu/map_menu.tscn")
var menu_scene := preload("res://ui/menus/main_menu/main_menu.tscn")
var main_menu : BaseMenu = null
var pause_menu : BaseMenu = null
var inventory_menu : BaseMenu = null
var map_menu : BaseMenu = null
var is_menu_open := true
var is_mouse_visible := true

# Called when the node enters the scene tree for the first time.
func _ready():
	player.add_known_location(e_rantel.get_map_data(), e_rantel.get_global_location())
	open_main_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and !is_menu_open:
		open_pause_menu()
	
	if  event.is_action_pressed("open_inventory") and ! is_menu_open:
		open_inventory_menu()
		
	if  event.is_action_pressed("open_map") and ! is_menu_open:
		open_map_menu()
	
	if  event.is_action_pressed("toggle_mouse_visible") and ! is_menu_open:
		toggle_mouse_visible()
		
func toggle_mouse_visible(value = null):
	if value == null:
		if is_mouse_visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			is_mouse_visible = false
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			is_mouse_visible = true
	else:
		if value:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			is_mouse_visible = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			is_mouse_visible = false
		
func open_menu():
	is_menu_open = true
	get_tree().paused = true
	toggle_mouse_visible(true)
	
func close_menu():
	is_menu_open = false
	get_tree().paused = false
	toggle_mouse_visible(false)
			
func open_main_menu():
	open_menu()
	main_menu = menu_scene.instantiate()
	menu_list.add_child(main_menu)
	main_menu.connect("new_game_signal",_on_main_menu_new_game_signal)

func close_main_menu():
	close_menu()
	main_menu.queue_free()
	main_menu = null
	
func open_pause_menu():
	open_menu()
	pause_menu = pause_scene.instantiate()
	menu_list.add_child(pause_menu)
	pause_menu.connect("close_menu_signal",close_pause_menu)

func close_pause_menu():
	close_menu()
	pause_menu.queue_free()
	pause_menu = null
	
func open_inventory_menu():
	open_menu()
	inventory_menu = inventory_scene.instantiate()
	#inventory_menu.init()
	menu_list.add_child(inventory_menu)
	inventory_menu.connect("close_menu_signal",close_inventory_menu)

func close_inventory_menu():
	close_menu()
	inventory_menu.queue_free()
	inventory_menu = null
	
func open_map_menu():
	open_menu()
	map_menu = map_scene.instantiate()
	map_menu.init(player)
	menu_list.add_child(map_menu)
	map_menu.connect("close_menu_signal",close_map_menu)

func close_map_menu():
	close_menu()
	map_menu.queue_free()
	map_menu = null
	
func _on_location_discovered(data: MapIconData, new_location: Vector3):
	player.add_known_location(data, new_location)

func _on_main_menu_new_game_signal():
#	map_menu.Init(player.get_map_icon_data())
	close_main_menu()

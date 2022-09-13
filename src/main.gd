extends Node

@onready var menu_list := $UI
@onready var save_system := $SaveSystem
@onready var characters = $Characters
@onready var levels = $Levels

var pause_scene : PackedScene = preload("res://ui/menus/pause_menu/pause_menu.tscn")
var inventory_scene : PackedScene = preload("res://ui/menus/inventory_menu/inventory_menu.tscn")
var map_scene : PackedScene = preload("res://ui/menus/map_menu/map_menu.tscn")
var player_scene : PackedScene = preload("res://entities/player_entity/player_entity_3d.tscn")
var player : PlayerEntity3D = null
var player_ui_scene : PackedScene = preload("res://ui/first_person_ui/first_person_ui.tscn")
var player_ui : FirstPersonUI = null
var carne_scene : PackedScene = preload("res://levels/carne_village/carne_village.tscn")
var character_creator_scene : PackedScene = preload("res://levels/character_creator/character_editor.tscn")
var character_creator : Node3D = null
var character_creator_menu_scene : PackedScene = preload("res://ui/menus/character_creator/character_creator_menu.tscn")
var main_menu_scene : PackedScene = preload("res://levels/main_menu/main_menu_scene.tscn")
var main_menu : Node3D = null
var main_menu_ui_scene : PackedScene = preload("res://ui/menus/main_menu/main_menu.tscn")
var main_menu_ui : BaseMenu = null
var pause_menu : BaseMenu = null
var inventory_menu : BaseMenu = null
var map_menu : BaseMenu = null
var character_creator_menu : CharacterCreatorMenu = null
var is_menu_open := true
var is_mouse_visible := true
var save_file_list : Array[String] = []

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
		
func open_menu(pause = true):
	is_menu_open = true
	get_tree().paused = pause
	toggle_mouse_visible(true)
	
func close_menu(pause = false):
	is_menu_open = false
	get_tree().paused = pause
	toggle_mouse_visible(false)
			
func open_main_menu():
	open_menu()
	main_menu = main_menu_scene.instantiate()
	levels.add_child(main_menu)
	main_menu_ui = main_menu_ui_scene.instantiate()
	menu_list.add_child(main_menu_ui)
	save_file_list = save_system.get_save_file_list()
	main_menu_ui.init(save_file_list)
	main_menu_ui.connect("new_game_signal",_on_main_menu_new_game_signal)

func close_main_menu():
	close_menu()
	main_menu_ui.queue_free()
	main_menu_ui = null
	main_menu.queue_free()
	main_menu = null
	
func open_pause_menu():
	open_menu()
	pause_menu = pause_scene.instantiate()
	menu_list.add_child(pause_menu)
	save_file_list = save_system.get_save_file_list()
	pause_menu.init(save_file_list)
	pause_menu.connect("close_menu_signal",close_pause_menu)

func close_pause_menu():
	close_menu()
	pause_menu.queue_free()
	pause_menu = null
	
func open_inventory_menu():
	open_menu()
	inventory_menu = inventory_scene.instantiate()
	menu_list.add_child(inventory_menu)
	#inventory_menu.init()
	inventory_menu.connect("close_menu_signal",close_inventory_menu)

func close_inventory_menu():
	close_menu()
	inventory_menu.queue_free()
	inventory_menu = null
	
func open_map_menu():
	open_menu()
	map_menu = map_scene.instantiate()
	menu_list.add_child(map_menu)
	map_menu.init(player)
	map_menu.connect("close_menu_signal",close_map_menu)

func close_map_menu():
	close_menu()
	map_menu.queue_free()
	map_menu = null
	
func open_character_creator_menu():
	open_menu(false)
	character_creator_menu = character_creator_menu_scene.instantiate()
	menu_list.add_child(character_creator_menu)
	character_creator_menu.connect("close_menu_signal",close_character_creator_menu)
	character_creator = character_creator_scene.instantiate()
	levels.add_child(character_creator)
	player = player_scene.instantiate()
	characters.add_child(player)
	character_creator_menu.init(player)
	player.freeze = true

func close_character_creator_menu():
	close_menu()
	character_creator_menu.queue_free()
	character_creator_menu = null
	character_creator.queue_free()
	character_creator = null
	player.queue_free()
	player = null
	open_main_menu()
	
func _on_location_discovered(data: MapIconData, new_location: Vector3):
	player.add_known_location(data, new_location)

func _on_main_menu_new_game_signal():
	close_main_menu()
	open_character_creator_menu()
	
func start_new_game():
	var carne = carne_scene.instantiate()
	levels.add_child(carne)
	player.add_known_location(carne.get_map_data(), carne.get_global_location())
	player.position = carne.get_global_location()
	close_main_menu()

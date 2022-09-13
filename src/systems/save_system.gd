extends Node
class_name SaveSystem

var current_save_file_name : String = ""
var save_file_list : Array[String] = []

func _ready():
	var dir = Directory.new()
	if dir.make_dir_recursive("user://saves/") != OK:
		print("An error occurred when trying to create the path")
	if dir.open("user://saves/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if !dir.current_is_dir():
				save_file_list.push_back(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func get_save_file_name() -> String:
	return current_save_file_name
	
func set_save_file_name(name : String):
	current_save_file_name = name
	
func get_save_file_list() -> Array[String]:
	return save_file_list

func save_to_file(data : Dictionary):
	pass
	
func load_from_file() -> Dictionary:
	return {}
	
func file_exists() -> bool:
	return true

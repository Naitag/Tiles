extends Node

class Test extends Node:
	var script_: Script

func _ready():
	var directory = Directory.new()
	directory.open("res://Levels/")
	directory.list_dir_begin()
	var file_name = directory.get_next()
	while file_name != "":
		if not directory.current_is_dir() and not file_name.ends_with("_new.json"):
			var level = HelperFunc.load_from_file("res://Levels/" + file_name)[0] as Level
			file_name = file_name.replace(".json", "_new.json")
			HelperFunc.save_to_file_new("res://Levels/" + file_name, level)
		file_name = directory.get_next()

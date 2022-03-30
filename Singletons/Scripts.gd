extends Node

var _dynamicaly_loaded_scripts = {}
var _dynamicaly_loaded_scenes = {}

var enum_direction_script = preload("res://Enums/Direction.gd")
var enum_tile_color_script = preload("res://Enums/TileColor.gd")
var modifier_create_object_script = preload("res://Classes/ModifierCreateObject.gd")
var score_multiplier_options_script = preload("res://Objects/ScoreMultiplierOptions.gd")
var double_color_options_script = preload("res://Objects/DoubleColorOptions.gd")
var extra_moves_modifier_options_script = preload("res://Objects/ExtraMovesModifierOptions.gd")
var arrow_modifier_options_script = preload("res://Objects/ArrowModifierOptions.gd")

func get_dynamicaly_loaded_script(path: String) -> Script:
	if not _dynamicaly_loaded_scripts.has(path):
		_dynamicaly_loaded_scripts[path] = load(path)
	
	return _dynamicaly_loaded_scripts[path]

func get_dynamicaly_loaded_scene(path: String) -> PackedScene:
	if not _dynamicaly_loaded_scenes.has(path):
		_dynamicaly_loaded_scenes[path] = load(path)
	
	return _dynamicaly_loaded_scenes[path]

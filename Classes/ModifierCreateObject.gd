extends Node
class_name ModifierCreateObject

var modifier_script: Script
var modifier_options: Node
var chance: float

static func create(script: Script, options: Node, chance_: float) -> ModifierCreateObject:
	var instance = Scripts.modifier_create_object_script.new() as ModifierCreateObject
	instance.modifier_script = script
	instance.modifier_options = options
	instance.chance = chance_
	
	return instance

func get_packed_scene() -> PackedScene:
	var scene_path = modifier_script.resource_path.replace(".gd", ".tscn")
	return Scripts.get_dynamicaly_loaded_scene(scene_path)

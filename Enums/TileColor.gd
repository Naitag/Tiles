extends Node
class_name TileColor

var value: String

static func create(value_: String):
	var i = Scripts.enum_tile_color_script.new()
	i.value = value_
	return i

func equals(other: TileColor) -> bool:
	return value == other.value

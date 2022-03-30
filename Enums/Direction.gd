extends Node
class_name Direction

var value: String

static func create(value_: String):
	var i = Scripts.enum_direction_script.new()
	i.value = value_
	return i

func equals(other: Direction) -> bool:
	return value == other.value

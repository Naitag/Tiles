extends Node
class_name LongSelectionMultiplierOption

var number_of_selected_tiles: int
var multiplier: int

static func create(number_of_selected_tiles_: int, multiplier_: int) -> LongSelectionMultiplierOption:
	var script = load("res://Classes/LongSelectionMultiplierOption.gd")
	var lsmo = script.new()
	lsmo.number_of_selected_tiles = number_of_selected_tiles_
	lsmo.multiplier = multiplier_
	return lsmo

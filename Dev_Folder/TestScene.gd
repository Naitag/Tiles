extends Node

func _ready():
	var l = LongSelectionMultiplierOption.new()
	l.set_test(10)._test
	
	var level = Level.new()
	var game_options = level.game_options
	game_options.tile_modifiers = [
		l
	]
	
	var dict = HelperFunc.to_dict(level)
	print(JSON.print(dict, "  "))
	
	var b = HelperFunc.from_dict(dict)
	var a = 1

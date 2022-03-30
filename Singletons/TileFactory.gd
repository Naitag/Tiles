extends Node

onready var tile_scene = load("res://Objects/Tile.tscn")

var _level_id
var _level_modifier_kinds
var _kinds_that_cant_exists_together

func create_random_tile(node: Node) ->  Tile:
	var tile = tile_scene.instance()
	node.add_child(tile)
	
	var game_options = Options.current_level.game_options
	
	var color = Constants.ALL_COLORS[randi() % game_options.number_of_tile_colors as int]
	tile.set_color(color)
	
	var tile_modifiers = game_options.tile_modifiers
	for modifier in tile_modifiers:
		var mco = modifier as ModifierCreateObject
		if _roll(mco.chance):
			var instance = mco.get_packed_scene().instance()
			instance.options = mco.modifier_options

			if instance is DoubleColor:
				var modifier_color = tile.get_random_color_not_in_tile()
				instance.color = modifier_color
				tile.colors.append(modifier_color)
			elif instance is ArrowModifier:
				var all_directions_size = Constants.ALL_DIRECTIONS.size()
				instance.direction = Constants.ALL_DIRECTIONS[randi() % all_directions_size]

			tile.add_modifier(instance)
			break

	return tile


func _roll(chance: float) -> bool:
	var random = randf()
	return random < chance

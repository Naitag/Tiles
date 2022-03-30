extends Node

func add_modifier_to_tile(kind: TileModifierKind, type: TileModifierType, tile: Tile) -> TileModifier:
	var modifier = null
	if kind == TileModifierKind.SCORE_MULTIPLIER:
		modifier = ScoreMultiplier.new(type)
		tile.add_modifier(modifier)
	elif kind == TileModifierKind.COLOR_MODIFIER:
		if type == TileModifierType.DOUBLE_COLOR:
			modifier = DoubleColor.new(type)
			var color = _get_random_color_not_in_tile(tile)
			modifier.set_color(color)
			tile.add_modifier(modifier)
	elif kind == TileModifierKind.EXTRA_MOVES:
		modifier = ExtraMovesModifier.new(type)
		tile.add_modifier(modifier)

	return modifier
	
func _get_random_color_not_in_tile(tile: Tile) -> int:
	var colors_availible = []
	for i in TileColor.ALL.size():
		if i >= Options.current_level.game_options.number_of_tile_colors:
			break
		
		colors_availible.append(TileColor.ALL[i])
		
	var tile_colors = tile.colors

	for color in tile_colors:
		colors_availible.erase(color)

	var i = randi() % colors_availible.size()
	return colors_availible[i]

extends Node

onready var tile_scene = load("res://Objects/Tile.tscn")

var _level_id
var _level_modifier_kinds
var _kinds_that_cant_exists_together

func create_random_tile(node: Node) ->  Tile:
	var level_modifier_kinds = _get_current_level_modifier_kinds()
	var kinds_that_cant_exists_together = _get_kinds_that_cant_exists_together()
	
	var tile = tile_scene.instance()
	node.add_child(tile)
	
	var game_options = Options.current_level.game_options
	var color = TileColor.ALL[randi() % game_options.number_of_tile_colors as int]
	tile.set_color(color)

	var added_kinds = []
	for kind in level_modifier_kinds:
		if added_kinds.has(kind):
			continue
		var added_modifier = _set_modifier(tile, kind)
		if added_modifier != null and kinds_that_cant_exists_together.has(kind.get_idn()):
			added_kinds.append_array(kinds_that_cant_exists_together[kind.get_idn()])

	return tile
	
func _get_kinds_that_cant_exists_together() -> Dictionary:
	if _kinds_that_cant_exists_together == null:
		_kinds_that_cant_exists_together = {
			TileModifierKind.SCORE_MULTIPLIER.get_idn(): [TileModifierKind.SCORE_MULTIPLIER, TileModifierKind.EXTRA_MOVES],
			TileModifierKind.EXTRA_MOVES.get_idn(): [TileModifierKind.EXTRA_MOVES, TileModifierKind.SCORE_MULTIPLIER],
		}
	
	return _kinds_that_cant_exists_together
	
func _get_current_level_modifier_kinds() -> Array:
	if _level_id != null and _level_id == Options.current_level.id:
		return _level_modifier_kinds
	
	_level_modifier_kinds = []
	var game_options = Options.current_level.game_options
	for m in game_options.tile_modifiers:
		var modifier = m as TileModifierOption
		if _level_modifier_kinds.find(modifier.kind) == -1:
			_level_modifier_kinds.append(modifier.kind)
	
	return _level_modifier_kinds

func _set_modifier(tile: Tile, kind: TileModifierKind) -> TileModifier:
	var game_options = Options.current_level.game_options
	for m in game_options.tile_modifiers:
		var random = randf()
		var modifier = m as TileModifierOption
		if modifier.kind != kind:
			continue
		
		var chance = modifier.chance
		if random < chance:
			return ModifierFactory.add_modifier_to_tile(modifier.kind, modifier.type, tile)
	
	return null

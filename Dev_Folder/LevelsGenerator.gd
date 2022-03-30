extends Node

onready var levels = []

func _on_level_star_scores(level: Level, scores: Array):
	if not scores.empty():
		level.score_thresholds = scores
		HelperFunc.save_to_file("res://Levels/level_%s.json" % level.id, [level])
	var index = levels.find(level)
	if index < levels.size() - 1:
		$Tests.get_level_star_scores(levels[index + 1])

func _ready():
	$Tests.connect("level_star_scores", self, "_on_level_star_scores")
	
	var game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.05),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.03),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.03),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.03),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
		LongSelectionMultiplierOption.create(9, 40),
	]
	_add_level(game_options)

	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.05),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.03),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.03),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
	]
	_add_level(game_options)

	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.03),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 20),
		LongSelectionMultiplierOption.create(9, 40),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_2,
			0.03),
	]
	game_options.long_selection_multipliers = [
		
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_3,
			0.03),
	]
	game_options.long_selection_multipliers = [
		
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_4,
			0.02),
	]
	game_options.long_selection_multipliers = [
		
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_5,
			0.01),
	]
	game_options.long_selection_multipliers = [
		
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_2,
			0.03),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 100),
		LongSelectionMultiplierOption.create(7, 200),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_2,
			0.03),
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_3,
			0.01),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 15),
		LongSelectionMultiplierOption.create(7, 30),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_5,
			0.01),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.01),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.03),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 15),
		LongSelectionMultiplierOption.create(7, 30),
	]
	_add_level(game_options)

	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_2,
			0.03),
	]
	game_options.long_selection_multipliers = [
		
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_3,
			0.03),
	]
	game_options.long_selection_multipliers = [
		
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_4,
			0.02),
	]
	game_options.long_selection_multipliers = [
		
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_5,
			0.01),
	]
	game_options.long_selection_multipliers = [
		
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_2,
			0.03),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 100),
		LongSelectionMultiplierOption.create(7, 200),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_2,
			0.03),
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_3,
			0.01),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 15),
		LongSelectionMultiplierOption.create(7, 30),
	]
	_add_level(game_options)
	
	game_options = GameOptions.new()
	game_options.number_of_tile_colors = 4
	game_options.grid_rows = 10
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_5,
			0.01),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.01),
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.03),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 15),
		LongSelectionMultiplierOption.create(7, 30),
	]
	_add_level(game_options)
	
	Options.is_test = true
	$Tests.get_level_star_scores(levels[0])
	
func _add_level(game_options: GameOptions):
	var i = levels.size()
	var name = "Level %d" % (i + 1)
	var level = Level.new()
	level.id = i
	level.level_name = name
	level.level_game = true

	game_options.fixed_seed = name
	level.game_options = game_options
	
	levels.append(level)

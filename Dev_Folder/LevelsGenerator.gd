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
	
	var modifiers = [
		ModifierCreateObject.create(
			ScoreMultiplier,
			ScoreMultiplierOptions.create(2),
			0.05	
		),
		ModifierCreateObject.create(
			ScoreMultiplier,
			ScoreMultiplierOptions.create(3),
			0.05	
		),
		ModifierCreateObject.create(
			ScoreMultiplier,
			ScoreMultiplierOptions.create(4),
			0.05	
		),
		ModifierCreateObject.create(
			ScoreMultiplier,
			ScoreMultiplierOptions.create(5),
			0.05	
		),
		ModifierCreateObject.create(
			ExtraMovesModifier,
			ExtraMovesModifierOptions.create(2),
			0.03
		),
		ModifierCreateObject.create(
			ExtraMovesModifier,
			ExtraMovesModifierOptions.create(3),
			0.02
		),
		ModifierCreateObject.create(
			ExtraMovesModifier,
			ExtraMovesModifierOptions.create(4),
			0.01
		),
		ModifierCreateObject.create(
			ExtraMovesModifier,
			ExtraMovesModifierOptions.create(5),
			0.01
		),
		ModifierCreateObject.create(
			DoubleColor,
			DoubleColorOptions.create(),
			0.05
		),
		ModifierCreateObject.create(
			ArrowModifier,
			ArrowModifierOptions.create(),
			0.05
		)
	]

	var game_options = GameOptions.new()
	game_options.number_of_tile_colors = 3
	game_options.number_of_moves = 20
	game_options.tile_modifiers = [
	]
	_add_level(game_options)

	for m in modifiers:
		game_options = GameOptions.new()
		game_options.number_of_tile_colors = 3
		game_options.number_of_moves = 20
		game_options.tile_modifiers = [
			m
		]
		_add_level(game_options)
		
	for i in modifiers.size() - 2:
		var m = modifiers[i]
		game_options = GameOptions.new()
		game_options.number_of_tile_colors = 3
		game_options.number_of_moves = 20
		game_options.tile_modifiers = [
			modifiers[modifiers.size() - 2],
			m
		]
		_add_level(game_options)
		
	for i in modifiers.size() - 2:
		var m = modifiers[i]
		game_options = GameOptions.new()
		game_options.number_of_tile_colors = 3
		game_options.number_of_moves = 20
		game_options.tile_modifiers = [
			modifiers[modifiers.size() - 1],
			m
		]
		_add_level(game_options)
		
	for i in modifiers.size() - 2:
		var m = modifiers[i]
		game_options = GameOptions.new()
		game_options.number_of_tile_colors = 3
		game_options.number_of_moves = 20
		game_options.tile_modifiers = [
			modifiers[modifiers.size() - 2],
			modifiers[modifiers.size() - 1],
			m
		]
		_add_level(game_options)
		
#	game_options = GameOptions.new()
#	game_options.number_of_tile_colors = 4
#	game_options.grid_rows = 10
#	game_options.number_of_moves = 20
#	game_options.tile_modifiers = [
#	]
#	_add_level(game_options)
#
#	for m in modifiers:
#		game_options = GameOptions.new()
#		game_options.number_of_tile_colors = 4
#		game_options.grid_rows = 10
#		game_options.number_of_moves = 20
#		game_options.tile_modifiers = [
#			m,
#			ModifierCreateObject.create(
#				ArrowModifier,
#				ArrowModifierOptions.create(),
#				0.05
#			)
#		]
#		_add_level(game_options)
	
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

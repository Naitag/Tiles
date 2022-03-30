extends Node

var _levels_dir = "res://Levels/"
var _levels_file_path = "res://levels.json"
var _levels: Array = []

var _finished_levels_file_path = "user://finished_levels.json"
var _finished_levels: Array = []

var _quick_game_level: Level
var _test_game_level: Level

func _ready():
	load_levels_from_file()
	load_finished_games_from_file()
	
	_init_quick_game_level()
	if OS.is_debug_build():
		_init_test_game_level()

func load_levels_from_file():
	var levels = []
	
	var directory = Directory.new()
	directory.open(_levels_dir)
	directory.list_dir_begin()
	var file_name = directory.get_next()
	while file_name != "":
		if not directory.current_is_dir() and not file_name.ends_with("_new.json"):
			var level = HelperFunc.load_from_file(_levels_dir + file_name)[0] as Level
			level.level_game = true
			levels.append(level)
		file_name = directory.get_next()
	
	levels.sort_custom(self, "_custom_sort_levels")
	_levels = levels

func load_finished_games_from_file():
#	_finished_levels = HelperFunc.load_from_file(_finished_levels_file_path)
	for i in _levels.size():
		var level = _levels[i] as Level
		
		if i >= _finished_levels.size():
			var finished_level = FinishedLevel.create(level.id, 0, 0)
			_finished_levels.append(finished_level)
	
func load_level(id: int):
	var level = get_level(id)
	Options.current_level = level
	
func load_quick_game():
	Options.current_level = _quick_game_level
	
func load_test_game():
	Options.current_level = _test_game_level
	
func number_of_levels() -> int:
	return _levels.size()
	
func get_levels_info() -> Array:
	var result = []
	for i in _levels.size():
		var level = _levels[i] as Level
		result.append({"id": level.id, "level_name": level.level_name})
	
	return result

func is_any_level_finished() -> bool:
	for fl in _finished_levels:
		var finished_level = fl as FinishedLevel
		if finished_level.number_of_stars > 0:
			return true
	
	return false

func save_finished_level(level: Level, score: int):
	var id = level.id

	var number_of_stars = 0
	for i in level.score_thresholds.size():
		var score_threshold = level.score_thresholds[i]
		if score >= score_threshold:
			number_of_stars = i + 1

	var finished_level = get_finished_level(id)
	if finished_level:
		if finished_level.number_of_stars < number_of_stars:
			finished_level.number_of_stars = number_of_stars
		if finished_level.score < score:
			finished_level.score = score

		HelperFunc.save_to_file(_finished_levels_file_path, _finished_levels)
		
func get_level(id: int) -> Level:
	for l in _levels:
		var level = l as Level
		if level.id == id:
			return level
	
	return null

func get_finished_level(id: int) -> FinishedLevel:
	for l in _finished_levels:
		var finished_level = l as FinishedLevel
		if finished_level.level_id == id:
			return finished_level
	
	return null

func _init_quick_game_level():
	_quick_game_level = Level.new()
	_quick_game_level.id = -1
	_quick_game_level.quick_game = true
	var game_options = _quick_game_level.game_options
	game_options.number_of_moves = 30
	game_options.tile_modifiers = [
		ModifierCreateObject.create(ScoreMultiplier, ScoreMultiplierOptions.create(5), 0.005),
		ModifierCreateObject.create(ScoreMultiplier, ScoreMultiplierOptions.create(4), 0.015),
		ModifierCreateObject.create(ScoreMultiplier, ScoreMultiplierOptions.create(3), 0.025),
		ModifierCreateObject.create(ScoreMultiplier, ScoreMultiplierOptions.create(2), 0.035),
		ModifierCreateObject.create(ScoreMultiplier, ScoreMultiplierOptions.create(2), 0.035),
		ModifierCreateObject.create(DoubleColor, DoubleColorOptions.create(), 0.035),
		ModifierCreateObject.create(ArrowModifier, ArrowModifierOptions.create(), 0.2),
	]
	game_options.long_selection_multipliers = [
		LongSelectionMultiplierOption.create(5, 10),
		LongSelectionMultiplierOption.create(7, 30),
		LongSelectionMultiplierOption.create(9, 50),
		LongSelectionMultiplierOption.create(11, 100),
		LongSelectionMultiplierOption.create(13, 150),
	]

func _init_test_game_level():
	_test_game_level = Level.new()
	_test_game_level.id = -2
	var game_options = _test_game_level.game_options
	game_options.number_of_tile_colors = 2
	game_options.number_of_moves = 1
	game_options.tile_modifiers = [

	]
	game_options.long_selection_multipliers = [
	]

func _custom_sort_levels(a, b):
	return a.id < b.id

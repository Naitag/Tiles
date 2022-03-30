extends Node

signal level_star_scores

var grid
var grid_scene = load("res://Objects/Grid.tscn")

var number_of_tests = 1000
var i = 0
var level_results = []

var number_of_moves_made = 0

var random_generator = RandomNumberGenerator.new()

func comaprison(a, b):
	return a.score < b.score

func _ready():
	OS.vsync_enabled = false
	Engine.time_scale = 2
	Engine.iterations_per_second = 240
	ScoreCounter.connect("game_over", self, "game_over")

func start_tests():
	if grid != null and grid.is_connected("updated", self, "_on_grid_updated"):
		grid.disconnect("updated", self, "_on_grid_updated")
	
	ScoreCounter.reset(Options.current_level.game_options.number_of_moves)
	grid = grid_scene.instance()
	grid.connect("updated", self, "_on_grid_updated")
	grid.testing = true
	add_child(grid)
	
	_on_grid_updated()

func get_level_star_scores(level: Level):
	var saved_level = LevelsManager.get_level(level.id)
	if not saved_level == null and not saved_level.score_thresholds.empty():
		var saved_level_dict = HelperFunc.to_dict(saved_level)
		saved_level_dict["score_thresholds"] = []
		
		var new_level_dict = HelperFunc.to_dict(level)
		
		if to_json(saved_level_dict) == to_json(new_level_dict):
			HelperFunc.save_to_file_new("res://Levels/level_%s_new.json" % level.id, level)
			print("skipping level: %s, hash identical" % level.id)
			emit_signal("level_star_scores", level, level.score_thresholds)
			return
	
	Options.current_level = level
	start_tests()
	
func game_over(score):
	var r = {
		"level_id": Options.current_level.id,
		"run": i,
		"number_of_moves_made": number_of_moves_made,
		"score": score
	}
	print(r)
	level_results.append(r)
	grid.queue_free()
	
	if i >= number_of_tests:
		i = 0
		
		level_results.sort_custom(self, "comaprison")
		
		var one_star_score = _get_avg_from_last_n_results(1000, level_results)
		var two_star_score = _get_avg_from_last_n_results(800, level_results)
		var three_star_score = _get_avg_from_last_n_results(600, level_results)
		
		emit_signal("level_star_scores", Options.current_level, [one_star_score, two_star_score, three_star_score])
		
		level_results = []
		return
		
	i += 1
	number_of_moves_made = 0
	start_tests()

func _on_grid_updated():
	if not is_instance_valid(grid):
		return

	var board = grid.board
	var path_finder = PathFinder.new(board)
	var path_to_select = []
	
	var try_number = 0
	while path_to_select.size() < 3:
		if try_number > 1000:
			game_over(-1)
			return
		try_number += 1
		random_generator.randomize()
		
		var slots = _get_slots_with_tiles_with_modifiers(board)
		var select_slot_with_modifier = random_generator.randf() < 0.05#0.4
		if select_slot_with_modifier and not slots.empty():
			var slot = slots[random_generator.randi() % slots.size()]
			path_to_select = path_finder.get_longest_path(slot)
		else:
			var i = random_generator.randi() % Options.current_level.game_options.grid_rows as int
			var j = random_generator.randi() % Options.current_level.game_options.grid_columns as int
			path_to_select = path_finder.get_longest_path(board.slots[i][j])

	for slot in path_to_select:
		grid.select_slot(slot)
		
	grid.selection_stop()
	number_of_moves_made += 1

func _get_slots_with_tiles_with_modifiers(board: Board) -> Array:
	var result = []
	for i in Options.current_level.game_options.grid_rows:
		for j in Options.current_level.game_options.grid_columns:
			var slot = board.slots[i][j]
			if not slot.is_empty() and not slot.tile.get_modifiers().empty():
				result.append(slot)
	
	return result
				
	
func _get_avg_from_last_n_results(n: int, results: Array):
	var size = results.size()
	var first_index = size - n - 1
	var star_score = 0
	for i in n:
		var score = results[first_index + i].score
		star_score += score
	
	return star_score / n

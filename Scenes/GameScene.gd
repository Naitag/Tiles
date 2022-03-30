extends Control

var _next_level = null
var need_hint = true

func _input(ev) -> void:
	get_viewport().unhandled_input(ev)

func _ready():
	var err = ScoreCounter.connect("score_changed", self, "_on_score_changed")
	assert(err == 0)
	err = ScoreCounter.connect("moves_left_changed", self, "_on_moves_left_changed")
	assert(err == 0)
	err = ScoreCounter.connect("game_over", self, "_on_game_over")
	assert(err == 0)
	err = ScoreCounter.connect("current_selection_score", self, "_on_current_selection_score")
	assert(err == 0)
	err = ScoreCounter.connect("info_changed", self, "_on_info_changed")
	assert(err == 0)
	
	var game_option = Options.current_level.game_options
	ScoreCounter.reset(game_option.number_of_moves)
	
	$ViewportContainer/Viewport.set_size_override_stretch(true)
	
	_init_hint()
	
func _init_hint():
	if LevelsManager.is_any_level_finished() or Highscore.has_any_score():
		need_hint = false
		return

	var grid = $ViewportContainer/Viewport/Grid
	var board = grid.board as Board
	var path_finder = PathFinder.new(board)
	var path
	var random_generator = RandomNumberGenerator.new()
	var try_number = 0
	while path == null:
		if try_number > 1000:
			return
		try_number += 1
		random_generator.randomize()
		var i = random_generator.randi() % grid.rows as int
		var j = random_generator.randi() % grid.columns as int
		path = path_finder.find_path_of_length(board.slots[i][j], 3)

	yield(get_tree().create_timer(3), "timeout")

	while need_hint:
		for slot in path:
			grid.fake_select_slot(slot)
			if grid.stop_fake_selections:
				break
			yield(get_tree().create_timer(1), "timeout")
		
		yield(get_tree().create_timer(3), "timeout")
		if grid.stop_fake_selections:
			yield(get_tree().create_timer(1), "timeout")
			continue
		
		grid.deselect_fake_selected_slots()
		yield(get_tree().create_timer(3), "timeout")

func _on_score_changed(score: int):
	if score > 0:
		need_hint = false
	var formated = HelperFunc.get_formated_number(score)
	$ScoreLabel.text = "Score: %s" % formated

func _on_moves_left_changed(moves_left: int):
	$MovesLeftLabel.text = "Moves left: " + str(moves_left)
	
func _on_game_over(score: int):
	if Options.current_level.daily_game:
		GameServer.send_daily_game_score(score)
		$QuickGameOverDialog.popup()
	elif Options.current_level.quick_game:
		Highscore.save_score(score)
		$QuickGameOverDialog.popup()
	elif Options.current_level.level_game:
		var level = Options.current_level
		LevelsManager.save_finished_level(level, score)

		var number_of_stars = 0
		for i in level.score_thresholds.size():
			var score_threshold = level.score_thresholds[i]
			if score >= score_threshold:
				number_of_stars = i + 1

		_next_level = LevelsManager.get_level(level.id + 1)
		if number_of_stars > 0 and _next_level:
			$LevelGameOverDialog/VBoxContainer/NextLevelButton.show()
		else:
			$LevelGameOverDialog/VBoxContainer/NextLevelButton.hide()
			
		$LevelGameOverDialog/StarThresholdInfo.set_star_scores(level)
			
		$LevelGameOverDialog.popup()
		
		yield(get_tree().create_timer(1), "timeout")
		$LevelGameOverDialog/StarScene.show_stars(number_of_stars)

func _on_new_finished_level(finished_level: FinishedLevel):
	if Options.current_level.game_options.daily_game:
		GameServer.do_action(GameServer.SendDailyGameResult.new(200))
		$QuickGameOverDialog.popup()
		return
	
	if finished_level:
		var number_of_stars = finished_level.number_of_stars
		_next_level = LevelsManager.get_level(finished_level.level_id + 1)
		if number_of_stars > 0 and _next_level:
			$LevelGameOverDialog/VBoxContainer/NextLevelButton.show()
		else:
			$LevelGameOverDialog/VBoxContainer/NextLevelButton.hide()
			
		var level = LevelsManager.get_level(finished_level.level_id)
		$LevelGameOverDialog/StarThresholdInfo.set_star_scores(level)
			
		$LevelGameOverDialog.popup()
		
		yield(get_tree().create_timer(1), "timeout")
		$LevelGameOverDialog/StarScene.show_stars(number_of_stars)
	else:
		$QuickGameOverDialog.popup()

func _on_current_selection_score(score: int, multiplier: int):
	var label = $CurrentSelectionScoreLabel
	var formated = HelperFunc.get_formated_number(score)
	label.text = "Current selection score: %s X %s" % [formated, str(multiplier)]
	
func _on_info_changed(info: String):
	var label = $InfoLabel
	label.text = info

func _on_BackButton_button_up():
	SceneManager.change_scene("res://Scenes/Menu.tscn")

func _on_HalfTransparentPopupDialog_on_close():
	SceneManager.change_scene("res://Scenes/Menu.tscn")

func _on_NextLevelButton_button_up_not_ouside():
	SceneManager.change_scene("res://Scenes/LevelsScene.tscn", {
		"open_level_id": _next_level.id
	})

func _on_TryAgainButton_button_up_not_ouside():
	SceneManager.change_scene("res://Scenes/GameScene.tscn")

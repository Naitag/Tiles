extends Node

signal score_changed
signal moves_left_changed
signal game_over
signal info_changed
signal current_selection_score

var _points_array = [0, 2, 3]
var _score: int
var _moves_number: int

var _last_3_selections = []
var _long_selection_multipliers
var _current_long_selection_multiplier = 1

func get_moves_numer() -> int:
	return _moves_number

func reset(moves_number: int):
	var game_options = Options.current_level.game_options
	_long_selection_multipliers = game_options.long_selection_multipliers
	_score = 0
	_moves_number = moves_number
	_last_3_selections = []
	emit_signal("score_changed", _score)
	emit_signal("moves_left_changed", _moves_number)
	
func compute_current_selection_score(selected_slots: Array):
	var multiplier = _get_long_selection_multiplier(_last_3_selections)
	
	var tiles_destroyed = selected_slots.size()
	if tiles_destroyed < 3:
		emit_signal("current_selection_score", 0, multiplier)
		return

	var current_score = _get_main_score(selected_slots)
	current_score = _get_score_with_modifiers(current_score, selected_slots)
	
	var _current_last_3_selections = _last_3_selections.duplicate()
	_current_last_3_selections.append(selected_slots)
	if _current_last_3_selections.size() > 3:
		_current_last_3_selections.remove(0)
		
	emit_signal("current_selection_score", current_score, multiplier)

func update_with_selected_slots(selected_slots: Array):
	var tiles_destroyed = selected_slots.size()
	if tiles_destroyed < 3:
		return

	_update_last_3_selections(selected_slots)
	
	var multiplier = _get_long_selection_multiplier(_last_3_selections)
	if multiplier > 1:
		emit_signal("info_changed", "")
	else:
		if not _long_selection_multipliers.empty():
			var first = _long_selection_multipliers.front() as LongSelectionMultiplierOption
			emit_signal("info_changed", "Make 3 selections with %d or more tiles for bonus multiplier" % first.number_of_selected_tiles)
	
	var score_to_add = _get_main_score(selected_slots)
	score_to_add = _get_score_with_modifiers(score_to_add, selected_slots)
	score_to_add = _get_score_with_long_selection_multiplier(score_to_add, _last_3_selections)
	
	_score += score_to_add

	emit_signal("score_changed", _score)

	_moves_number = _get_moves_with_modifiers(_moves_number, selected_slots)
	_moves_number -= 1
	emit_signal("moves_left_changed", _moves_number)

func check_if_game_is_over():
	if _moves_number == 0:
		emit_signal("game_over", _score)
		
func no_legal_moves():
	emit_signal("game_over", _score)
		
func _get_moves_with_modifiers(number_of_moves: int, selected_slots: Array):
	var result = number_of_moves
	var modifiers = []
	for slot in selected_slots:
		var m = slot.tile.get_modifiers()
		modifiers.append_array(m)
	
	for m in modifiers:
		if m is ExtraMovesModifier:
			result = m.modify_number_of_moves(result)
			
	return result
		
func _get_main_score(selected_slots: Array) -> int:
	var tiles_destroyed = selected_slots.size()
	var score_to_add = 0
	if tiles_destroyed == 3:
		score_to_add = 3
	elif tiles_destroyed < 6:
		score_to_add = (tiles_destroyed * (tiles_destroyed - 1))
	elif tiles_destroyed < 11:
		score_to_add = (tiles_destroyed * (tiles_destroyed + floor(tiles_destroyed / 2)))
	else:
		score_to_add = (tiles_destroyed * (tiles_destroyed + tiles_destroyed))
		
	return score_to_add
		
func _get_score_with_modifiers(score: int, selected_slots: Array):
	var result = score
	var modifiers = []
	for slot in selected_slots:
		var m = slot.tile.get_modifiers()
		modifiers.append_array(m)
	
	for m in modifiers:
		if m is ScoreMultiplier:
			result = m.modify_score(result)
			
	return result
	
func _get_score_with_long_selection_multiplier(score: int, last_3_selections: Array):
	var multiplier = _get_long_selection_multiplier(last_3_selections)
	return score * multiplier

func _update_last_3_selections(selection: Array):
	_last_3_selections.append(selection)
	if _last_3_selections.size() > 3:
		_last_3_selections.remove(0)

func _get_long_selection_multiplier(last_3_selections: Array) -> int:
	var multiplier = 1
	
	if last_3_selections.size() < 3:
		return multiplier
	
	for lsmo_ in _long_selection_multipliers:
		var lsmo = lsmo_ as LongSelectionMultiplierOption
		var all_numbers_above_threshold = true
		for selection in last_3_selections:
			if selection.size() < lsmo.number_of_selected_tiles:
				all_numbers_above_threshold = false
				break
		
		if all_numbers_above_threshold:
			multiplier = lsmo.multiplier
		else:
			return multiplier
	
	return multiplier

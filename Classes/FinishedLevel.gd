extends Node
class_name FinishedLevel

var level_id: int
var score: int
var number_of_stars = 0

static func create(level_id_: int, score_: int, number_of_stars_: int) -> FinishedLevel:
	var script = load("res://Classes/FinishedLevel.gd")
	var finished_level = script.new()
	finished_level.level_id = level_id_
	finished_level.score = score_
	finished_level.number_of_stars = number_of_stars_
	return finished_level

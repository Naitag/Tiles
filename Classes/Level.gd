extends Node
class_name Level

var id: int
var game_options: GameOptions = GameOptions.new()
var level_name: String
var score_thresholds: Array = []

var daily_game = false
var quick_game = false
var level_game = false

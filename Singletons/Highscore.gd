extends Node

var _file_path = "user://highscore.save"
var _highscores_count = 10
var _highscores = []

class Score:
	var score: int
	var uploaded = false

	static func sort(a: Score, b: Score):
		if a.score < b.score:
			return true
		return false

func _ready():
	_load_scores_from_file()

func _load_scores_from_file():
	var file = File.new()
	if not file.file_exists(_file_path):
		for i in _highscores_count:
			var score = Score.new()
			score.score = 0
			_highscores.append(score)
		return
	
	file.open(_file_path, File.READ)
	var file_line = file.get_line()
	var _dict_highscores = parse_json(file_line)
	var first = _dict_highscores[0]

	if typeof(first) == TYPE_INT or typeof(first) == TYPE_REAL:
		_highscores = []
		for i in _dict_highscores.size():
			var score = Score.new()
			score.score = _dict_highscores[i]
			_highscores.append(score)
		
		save_highscores()
	else:
		_highscores = []
		for dict in _dict_highscores:
			_highscores.append(dict2inst(dict))

	file.close()

func save_score(score: int):
	_highscores.sort_custom(Score, "sort")
	_highscores.invert()
	
	for i in _highscores.size():
		var _highscore = _highscores[i] as Score
		if score > _highscore.score:
			var newScore = Score.new()
			newScore.score = score
			_highscores.insert(i, newScore)
			break
			
	save_highscores()
	
func has_any_score() -> bool:
	for i in _highscores.size():
		var _highscore = _highscores[i] as Score
		if _highscore.score > 0:
			return true
	
	return false
	
func save_highscores():
	if _highscores.size() > 10:
		for i in range(10, _highscores.size()):
			_highscores.remove(i)
	
	var file = File.new()
	file.open(_file_path, File.WRITE)
	
	var dict_array = []
	for score in _highscores:
		dict_array.append(inst2dict(score))
	
	var json = to_json(dict_array)
	file.store_line(json)
	file.close()
	
func get_highscores() -> Array:
	return _highscores

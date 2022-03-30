extends Control

onready var font = load("res://Fonts/highscore_font.tres")
var colors = ["a2222e","097f47","254787"]

var _options: Dictionary

func _ready():
	$StartGameButton.hide()
	
	GameServer.connect("received_daily_game_scores", self, "_on_received_daily_game_scores")	
	GameServer.connect("received_daily_game_options", self, "_on_received_daily_game_options")
	
	GameServer.request_daily_game_scores()
	GameServer.request_daily_game()

func _on_received_daily_game_scores(scores_string: String):
	var scores_array = parse_json(scores_string)
	for i in scores_array.size():
		var score_dict = scores_array[i]
		var label = Label.new()
		#label.text = str(i + 1) + ". %s: %s" % [score_dict.displayName, HelperFunc.get_formated_number(score_dict.score)]
		label.text = str(i + 1) + ". %s" % HelperFunc.get_formated_number(score_dict.score)
		label.add_font_override("font", font)
		label.modulate = Color(colors[i % colors.size()])
		$CenterContainer/VBoxContainer.add_child(label)
		
func _on_received_daily_game_options(dailyGameString: String):
	if dailyGameString.empty():
		return
	
	var dict = parse_json(dailyGameString)
	if dict == null:
		PlayGamesServices.show_toast_short("Daily game currently unavailible")
		return

	var level = HelperFunc.from_dict(dict) as Level
	Options.current_level = level
	$StartGameButton.show()

func _on_StartGameButton_button_up():
	SceneManager.change_scene("res://Scenes/GameScene.tscn")

func _on_BackButton_button_up():
	SceneManager.change_scene("res://Scenes/Menu.tscn")

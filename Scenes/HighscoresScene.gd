extends Control

onready var font = load("res://Fonts/highscore_font.tres")
var _back_button_pressed = false

var colors = [Constants.DARK_RED, Constants.DARK_GREEN, Constants.DARK_BLUE]

func _ready():
	PlayGamesServices.connect("scores_uploaded", self, "_on_scores_uploaded")
	_refresh()
		
func _refresh():
	for child in $CenterContainer/VBoxContainer.get_children():
		if child is Label:
			child.queue_free()
		
	var highscores = Highscore.get_highscores()
	
	for i in highscores.size():
		var highscore = highscores[i] as Highscore.Score
		var label = Label.new()
		label.text = str(i + 1) + ". " + HelperFunc.get_formated_number(highscore.score)
		label.add_font_override("font", font)
		if highscore.uploaded:
			label.modulate = Constants.DARK_GREEN
		else:
			label.modulate = Constants.DARK_RED
		$CenterContainer/VBoxContainer.add_child(label)
		
	if not PlayGamesServices.is_signed_in():
		$UploadButton.hide()
		$ShowLeaderboardButton.hide()
	else:
		$UploadButton.show()
		$ShowLeaderboardButton.show()

func _on_scores_uploaded():
	_refresh()

func _on_BackButton_button_up():
	SceneManager.change_scene("res://Scenes/Menu.tscn")

func _on_ShowLeaderboardButton_button_up():
	PlayGamesServices.show_leaderboard()

func _on_UploadButton_button_up():
	PlayGamesServices.upload_highscores()


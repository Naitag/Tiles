extends Control
class_name Menu

func _ready():
	PlayGamesServices.connect("player_info_loaded", self, "_on_player_info_loaded")
	PlayGamesServices.connect("sign_in_success", self, "_on_sign_in_success")
	PlayGamesServices.connect("sign_in_failed", self, "_on_sign_in_failed")
	PlayGamesServices.connect("sign_out_success", self, "_on_sign_out_success")
	PlayGamesServices.connect("sign_out_failed", self, "_on_sign_out_failed")
	PlayGamesServices.load_player_info()

	show_hide_sign_buttons()
	
	if OS.is_debug_build():
		$CenterContainer/VBoxContainer/TestGameButtonButton.show()

func show_hide_sign_buttons():
	if PlayGamesServices.is_signed_in():
		$CenterContainer/VBoxContainer/SignInButton.hide()
		$CenterContainer/VBoxContainer/SignOutButton.show()
	else:
		$CenterContainer/VBoxContainer/SignInButton.show()
		$CenterContainer/VBoxContainer/SignOutButton.hide()

func _on_QuickGameButtonButton_button_up():
	LevelsManager.load_quick_game()
	SceneManager.change_scene("res://Scenes/GameScene.tscn")

func _on_StartGameButton_button_up():
	SceneManager.change_scene("res://Scenes/LevelsScene.tscn")

func _on_DailyGameButton_button_up():
	SceneManager.change_scene("res://Scenes/DailyGameScene.tscn")

func _on_HighscoreButton_button_up():
	SceneManager.change_scene("res://Scenes/HighscoresScene.tscn")

func _on_ExitButton_button_up():
	get_tree().quit()

func _on_player_info_loaded(display_name: String):
	$HelloLabel.text = "Hello %s" % display_name

func _on_SignInButton_button_up():
	PlayGamesServices.sign_in()

func _on_SignOutButton_button_up():
	GameServer.clear_token()
	PlayGamesServices.sign_out()
	
func _on_sign_in_success():
	show_hide_sign_buttons()
	PlayGamesServices.load_player_info()

func _on_sign_in_failed():
	pass
		
func _on_sign_out_success():
	show_hide_sign_buttons()
	$HelloLabel.text = "Hello guest"
	GameServer.clear_token()

func _on_sign_out_failed():
	pass


func _on_TestGameButtonButton_button_up_not_ouside():
	LevelsManager.load_test_game()
	SceneManager.change_scene("res://Scenes/GameScene.tscn")

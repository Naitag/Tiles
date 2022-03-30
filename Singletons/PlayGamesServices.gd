extends Node

signal player_info_loaded
signal sign_in_success
signal sign_in_failed
signal sign_out_success
signal sign_out_failed
signal scores_uploaded

var play_games_services
var http: HTTPRequest
var auth_code: String

var any_uploaded = false

var _leaderboard_id = "CgkImcqgw-ceEAIQAw"

func _ready():
	if Engine.has_singleton("GodotPlayGamesServices"):
		play_games_services = Engine.get_singleton("GodotPlayGamesServices")
		var show_popups := true 
		play_games_services.initWithWebClientId(show_popups, "1058582045977-9jfp7qeojfg5i295kns6uo37o7sjtjb1.apps.googleusercontent.com")

		play_games_services.connect("_on_sign_in_success", self, "_on_sign_in_success") # account_id: String
		play_games_services.connect("_on_sign_in_failed", self, "_on_sign_in_failed") # error_code: int
		play_games_services.connect("_on_sign_out_success", self, "_on_sign_out_success") # no params
		play_games_services.connect("_on_sign_out_failed", self, "_on_sign_out_failed") # no params
		play_games_services.connect("_on_player_info_loaded", self, "_on_player_info_loaded")
		play_games_services.connect("_on_leaderboard_score_submitted", self, "_on_leaderboard_score_submitted")
		play_games_services.connect("_on_leaderboard_score_submitting_failed", self, "_on_leaderboard_score_submitting_failed")

func is_signed_in() -> bool:
	if not play_games_services:
		return false
	return play_games_services.isSignedIn()

func sign_in():
	if not play_games_services:
		return
	play_games_services.signIn()

func _on_sign_in_success(account_id: String, server_auth_code: String) -> void:
	auth_code = server_auth_code

	play_games_services.showToast("Sign in success", "short")
	emit_signal("sign_in_success")
	
func _on_sign_in_failed(error_message: String) -> void:
	play_games_services.showToast("Sign in failed", "short")
	emit_signal("sign_in_failed")
	
func sign_out():
	if not play_games_services:
		return
	play_games_services.signOut()

func _on_sign_out_success() -> void:
	play_games_services.showToast("Sign out success", "short")
	emit_signal("sign_out_success")
  
func _on_sign_out_failed() -> void:
	play_games_services.showToast("Sign out failed", "short")
	emit_signal("sign_out_failed")
	
func show_toast_short(msg: String):
	play_games_services.showToast(msg, "short")

func show_toast_long(msg: String):
	play_games_services.showToast(msg, "long")
	
func load_player_info():
	if not play_games_services:
		return
	play_games_services.loadPlayerInfo()

func _on_player_info_loaded(info):
	var info_dictionary: Dictionary = parse_json(info)
	var display_name = info_dictionary["display_name"]
	if not display_name:
		display_name = "Player"

	var player_id = info_dictionary["player_id"]

	if auth_code:
		GameServer.ws_connect(player_id, auth_code)
		auth_code = ""
	
	emit_signal("player_info_loaded", display_name)

func show_leaderboard():
	if not play_games_services:
		return
	play_games_services.showLeaderBoard(_leaderboard_id)

func upload_highscores():
	if not play_games_services:
		return

	var highscores = Highscore.get_highscores()
	for s in highscores:
		var score = s as Highscore.Score
	
		if score.uploaded:
			continue
	
		if score.score > 0:
			any_uploaded = true
			play_games_services.submitLeaderBoardScore(_leaderboard_id, score.score)
			
	if not any_uploaded:
		play_games_services.showToast("You have no scores to upload", "long")
	
func _on_leaderboard_score_submitted(leaderboard_id: String):
	var highscores = Highscore.get_highscores()
	for s in highscores:
		var score = s as Highscore.Score
		score.uploaded = true

	Highscore.save_highscores()
	any_uploaded = false
	play_games_services.showToast("Your scores have been uploaded", "long")
	emit_signal("scores_uploaded")

func _on_leaderboard_score_submitting_failed(leaderboard_id: String):
	any_uploaded = false
	play_games_services.showToast("Sending scores has failed", "long")

extends Control

onready var vs_game_res = load("res://Scenes/VsGame.tscn")
onready var font = load("res://Fonts/highscore_font.tres")

func _ready():
	GameServer.connect("received_vs_games", self, "_on_received_vs_games")
	GameServer.connect("receices_start_vs_game", self, "_on_receices_start_vs_game")
	GameServer.send_get_vs_games()

func _on_CreateButton_button_up_not_ouside():
	GameServer.send_create_vs_game()

func _on_BackButton_button_up_not_ouside():
	SceneManager.change_scene("res://Scenes/Menu.tscn")

func _on_received_vs_games(games_string: String):
	print(games_string)
	var children = $ScrollContainer/VBoxContainer.get_children()
	for child in children:
		remove_child(child)
		child.queue_free()
	
	var games = parse_json(games_string)
	for game in games:
		var vs_game = vs_game_res.instance() as VsGame
		vs_game.id_value = game.GameID
		vs_game.owner_value = game.PlayerID
		vs_game.players_value = ""
		if game.Players:
			for i in game.Players.size():
				var player = game.Players[i]
				vs_game.players_value += player.DisplayName
				if i < game.Players.size() - 1:
					vs_game.players_value += ", "
		$ScrollContainer/VBoxContainer.add_child(vs_game)
		vs_game.play_button.connect("button_up_not_ouside", self, "_on_play_vs_game", [game.GameID])

func _on_play_vs_game(game_id: String):
	GameServer.send_start_game(game_id)
	
func _on_receices_start_vs_game(response: String):
	var dict = parse_json(response)
	var game = parse_json(dict.Game)
	
	var level = HelperFunc.from_dict(game) as Level
	Options.current_level = level
	SceneManager.change_scene("res://Scenes/GameScene.tscn")

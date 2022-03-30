extends Node

var _file_path = "user://token"
var _token = ""

var _server_url = "wss://tiles.simpleshapegames.com"
var http_request: HTTPRequest

signal _on_sign_in_response

signal received_daily_game_scores
signal received_daily_game_options
signal new_token
signal received_vs_games
signal receices_start_vs_game

onready var _websocket_client = WebSocketClient.new()
var _actions = {
	"getToken": "new_token",
	"getDailyGame": "received_daily_game_options",
	"getDailyGameResults": "received_daily_game_scores",
	"getVsGames": "received_vs_games",
	"startVsGame": "receices_start_vs_game"
}

func _ready():
	_load_token()
	if OS.is_debug_build():
		if OS.get_name() == "Windows" or OS.get_name() == "X11":
			_server_url = "ws://127.0.0.1:9000"
#			_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDcyODAwODEsInBsYXllcl9pZCI6InRlc3QifQ.GNNx9RBrPklCXXbfP1TMdMkIEKx0YwTWeuUjD16ZBeg"
		elif OS.get_name() == "Android":
			_server_url = "ws://192.168.1.240:9000"

	_websocket_client.connect("connection_established", self, "_connection_established")
	_websocket_client.connect("connection_closed", self, "_connection_closed")
	_websocket_client.connect("connection_error", self, "_connection_error")
	_websocket_client.connect("data_received", self, "_data_received")
	_websocket_client.connect("server_close_request", self, "_server_close_request")
	
	connect("new_token", self, "_on_new_token")
	
	if _token:
		_connect()
	
func request_daily_game():
	_do_action({
		"actionName": "getDailyGame"
	})
	
func request_daily_game_scores():
	_do_action({
		"actionName": "getDailyGameResults"
	})
	
func send_daily_game_score(score: int):
	_do_action({
		"actionName": "saveDailyGameResult",
		"params": {
			"score": score
		}
	})
	
func send_get_vs_games():
	_do_action({
		"actionName": "getVsGames",
		"params": {
			
		}
	})
	
func send_create_vs_game():
	_do_action({
		"actionName": "createVsGame",
		"params": {
			
		}
	})

func send_start_game(guid: String):
	_do_action({
		"actionName": "startVsGame",
		"params": {
			"GameID": guid
		}
	})

func _do_action(dict: Dictionary):
	var peer = _websocket_client.get_peer(1)
	var msg = to_json(dict).to_utf8()
	peer.put_packet(msg)
	
func _data_received():
	var pkt = _websocket_client.get_peer(1).get_packet()
	var message = pkt.get_string_from_utf8()
	var dict = parse_json(message)
	var sig = _actions.get(dict.actionName)
	emit_signal(sig, dict.response)
	
func _connect():
	var err = _websocket_client.connect_to_url(_server_url, [], false, [
		"Authorization: Bearer " + _token
	])
	
func ws_connect(player_id: String, auth_code: String):
	_websocket_client.connect_to_url(_server_url, [], false, [
		"Authorization: AuthCode " + auth_code,
		"PlayerId: " + player_id
	])
	
func _on_new_token(token: String):
	_save_token(token)
	print_debug("new token: %s" % token)
	
func _physics_process(delta):
	_websocket_client.poll()

func _connection_established(protocol):
	print("_connection_established" + str(protocol))
	
func _connection_closed(was_clean):
	print("_connection_closed " + str(was_clean))
	
func _connection_error():
	print_debug("_connection_error")
	
func _server_close_request(code: int, reason: String):
	print("_server_close_request %d %s" % [code, reason])

func _load_token():
	var file = File.new()
	if not file.file_exists(_file_path):
		return
	
	file.open(_file_path, File.READ)
	_token = file.get_line()
	file.close()
	
func _save_token(token: String):
	_token = token
	
	var file = File.new()
	file.open(_file_path, File.WRITE)
	file.store_line(_token)
	file.close()
	
func clear_token():
	_websocket_client.disconnect_from_host()
	_token = ""
	var dir = Directory.new()
	dir.remove(_file_path)

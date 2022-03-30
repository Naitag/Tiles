extends Node

# The port we will listen to
const PORT = 9080
# Our WebSocketServer instance
var _server = WebSocketServer.new()

func _ready():
	# Connect base signals to get notified of new client connections,
	# disconnections, and disconnect requests.
	_server.connect("client_connected", self, "_connected")
	_server.connect("client_disconnected", self, "_disconnected")
	_server.connect("client_close_request", self, "_close_request")
	# This signal is emitted when not using the Multiplayer API every time a
	# full packet is received.
	# Alternatively, you could check get_peer(PEER_ID).get_available_packets()
	# in a loop for each connected peer.
	_server.connect("data_received", self, "_on_data")
	# Start listening on the given port.
	var err = _server.listen(PORT)
	if err != OK:
		print("Unable to start server")
		set_process(false)
	else:
		printraw("started\n")

func _connected(id, proto):
	# This is called when a new peer connects, "id" will be the assigned peer id,
	# "proto" will be the selected WebSocket sub-protocol (which is optional)
	print("Client %d connected with protocol: %s" % [id, proto])

func _close_request(id, code, reason):
	# This is called when a client notifies that it wishes to close the connection,
	# providing a reason string and close code.
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])

func _disconnected(id, was_clean = false):
	# This is called when a client disconnects, "id" will be the one of the
	# disconnecting client, "was_clean" will tell you if the disconnection
	# was correctly notified by the remote peer before closing the socket.
	print("Client %d disconnected, clean: %s" % [id, str(was_clean)])

func _on_data(id):
	# Print the received packet, you MUST always use get_peer(id).get_packet to receive data,
	# and not get_packet directly when not using the MultiplayerAPI.
	var pkt = _server.get_peer(id).get_packet()
	var message = pkt.get_string_from_utf8()
	
	print(message)
	if message == "getRandomLevel":
		var level = _create_random_level()
		var dict = HelperFunc.to_dict(level)
		var json = JSON.print(dict)
		var peer = _server.get_peer(id)
		peer.put_packet(json.to_utf8())

func _process(delta):
	# Call this in _process or _physics_process.
	# Data transfer, and signals emission will only happen when calling this function.
	_server.poll()
	
func _create_random_level() -> Level:
	var score_multipliers = [
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X5,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X4,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X3,
			0.03),
		TileModifierOption.new(
			TileModifierKind.SCORE_MULTIPLIER,
			TileModifierType.SCORE_MULTIPIER_X2,
			0.03),
	]
	
	var color_modifiers = [
		TileModifierOption.new(
			TileModifierKind.COLOR_MODIFIER,
			TileModifierType.DOUBLE_COLOR,
			0.05),
	]
	
	var extra_moves = [
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_5,
			0.01),
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_4,
			0.02),
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_3,
			0.03),
		TileModifierOption.new(
			TileModifierKind.EXTRA_MOVES,
			TileModifierType.EXTRA_MOVES_2,
			0.03),
	]
	
	var level = Level.new()
	level.daily_game = true
	var game_options = level.game_options
	game_options.grid_rows = (randi() % 3) + 8
	game_options.fixed_seed = str(randi()).hash()
	
	var tile_modifiers = []
	tile_modifiers.append_array(_get_modifier(2, score_multipliers))
	tile_modifiers.append_array(_get_modifier(1, color_modifiers))
	tile_modifiers.append_array(_get_modifier(1, extra_moves))
	game_options.tile_modifiers = tile_modifiers
	
	var number_of_lsm = (randi() % 3) + 1
	var steps = [5, 7, 9, 11]
	var first_multiplier = ((randi() % 5) + 1) * 5
	
	for i in number_of_lsm:
		var multiplier = first_multiplier * (i + 1)
		var lsmo = LongSelectionMultiplierOption.create(steps[i], multiplier)
		game_options.long_selection_multipliers.append(lsmo)
		
	return level

func _get_modifier(count: int, modifiers: Array) -> Array:
	var result = []
	var copy = modifiers.duplicate(true)
	for i in count:
		var index = randi() % copy.size()
		var modifier = copy[index]
		copy.remove(index)
		result.append(modifier)
		
	return result

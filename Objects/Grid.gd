extends Node2D
class_name Grid

signal game_over
signal updated

var columns = 8
var rows = 8
var spacing = 4

var stop_fake_selections = false
var _fake_selected_slots = []

var selected_slots = []
var selecting = false
var tile_to_spawn_in_column = []

onready var _slots_updating_number = 0

var testing = false

var board: Board

onready var game_options = Options.current_level.game_options

func _init():
	for i in columns:
		tile_to_spawn_in_column.append(0)
	
func _ready():
	if Options.current_level.game_options.fixed_seed:
		seed(Options.current_level.game_options.fixed_seed.hash())
	else:
		randomize()
	
	rows = game_options.grid_rows
	columns = game_options.grid_columns
	board = Board.new(rows + 1, columns)
	var err = board.connect("slot_created", self, "_on_slot_created")
	assert(err == 0)
	
	var slot_scene = load("res://Objects/Slot.tscn")
	board.prepare_slots(slot_scene)

func _on_slot_created(slot: Slot, row: int, col: int):
	add_child(slot)
	var coordinates = board.get_slot_col_row(slot)
	set_slot_position_and_scale(slot, coordinates.col, coordinates.row)
	
	slot.connect("updated", self, "_on_slot_updated", [slot])
	
	if row == rows:
		slot.virtual = true
		return
	
	var tile = TileFactory.create_random_tile(self)
	set_slot_position_and_scale(tile, coordinates.col, coordinates.row)
	_put_tile_to_slot(tile, slot)

func _physics_process(_delta):
	if not testing and not selecting and selected_slots.size() > 0:
		selection_stop()

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			selecting = true
		else:
			selecting = false

func _on_tile_input_event(_viewport, _event, _shape_idx, slot):
	if selecting:
		select_slot(slot)

func set_slot_position_and_scale(node: Node2D, col: int, row: int):
	var columns_spacings = (board.columns) * spacing
	var rows_spacings = (board.rows) * spacing

	var vieport_rect = get_viewport()
	
	var width = vieport_rect.size.x - columns_spacings
	var height = vieport_rect.size.y - rows_spacings
	var width_height = min(width, height)

	var slot_width = width / board.columns
	var slot_height = height / board.rows
	var slot_width_height = min(slot_width, slot_height)

	var x_margin = 0
	#if width > height:
	x_margin = (vieport_rect.size.x / 2) - (slot_width_height * columns / 2) - (columns_spacings / 2)
		
	var x = x_margin + (col * slot_width_height) + (spacing * col)
	var y = (row * slot_width_height) + spacing * (row)
	
	var scale_vector = Vector2(slot_width_height, slot_width_height)
	
	if node is Tile:
		var size = node.sprite.texture.get_size()
		scale_vector = Vector2(slot_width_height / size.x, slot_width_height / size.y)

	node.position = Vector2(x, y)
	node.scale = scale_vector

func deselect_all_slots():
	for slot in selected_slots:
		slot.deselect()

	selected_slots = []
	stop_fake_selections = false

func select_slot(slot: Slot):
	if _slots_updating_number != 0:
		return

	stop_fake_selections = true
	deselect_fake_selected_slots()
	
	if slot.is_disabled():
		return
	
	if selected_slots.size() == 0:
		selected_slots = [slot]
		slot.select()
		return

	if slot.selected:
		return
	
	var last_selected_slot = selected_slots.back()

	if not are_slots_neighbours(slot, last_selected_slot):
		return

	var slot_to_left = board.get_slot_to_left(slot)
	if slot_to_left == last_selected_slot and slot.has_same_color(slot_to_left):
		slot.select()
		selected_slots.append(slot)

	var slot_to_right = board.get_slot_to_right(slot)
	if slot_to_right == last_selected_slot and slot.has_same_color(slot_to_right):
		slot.select()
		selected_slots.append(slot)

	var slot_above = board.get_slot_above(slot)
	if slot_above == last_selected_slot and slot.has_same_color(slot_above):
		slot.select()
		selected_slots.append(slot)

	var slot_below = board.get_slot_below(slot)
	if slot_below == last_selected_slot and slot.has_same_color(slot_below):
		slot.select()
		selected_slots.append(slot)
		
	ScoreCounter.compute_current_selection_score(selected_slots)
	
func fake_select_slot(slot: Slot):
	if stop_fake_selections:
		return
	slot.select()
	_fake_selected_slots.append(slot)
	
func deselect_fake_selected_slots():
	for slot in _fake_selected_slots:
		slot.deselect()
	
	_fake_selected_slots = []

func selection_stop():
	if selected_slots.size() < 3:
		deselect_all_slots()
		return

	ScoreCounter.update_with_selected_slots(selected_slots)
	ScoreCounter.compute_current_selection_score([])

	for slot in selected_slots:
		slot.remove_tile()

	deselect_all_slots()
	
	var to_update = _process_falling_off_grid_tiles()
	
	for i in range(rows - 1, -1, -1):
		for j in columns:
			var slots_to_update = replace_slot_with_cell_above(board.slots[i][j])
			for slot in slots_to_update:
				if to_update.find(slot) == -1:
					to_update.append(slot)

	for slot in to_update:
		_update_slot(slot)

	_reset_cell_to_spawn_in_columns()
	
func _check_if_game_is_over():
	var path_finder = PathFinder.new(board)
	for i in board.rows:
		for j in board.columns:
			var path_size_3 = path_finder.find_path_of_length(board.slots[i][j], 3)
			if path_size_3 != null:
				return
				
	ScoreCounter.no_legal_moves()
	
func _process_falling_off_grid_tiles() -> Array:
	for i in columns:
		var virtual_slot = board.slots[rows][i]
		var slot_above = board.get_slot_above(virtual_slot)
		while slot_above != null and slot_above.is_empty():
			slot_above = board.get_slot_above(slot_above)
			
		if slot_above == null:
			continue
		
		var tile = slot_above.tile
		var falling_off_grid = tile.falling_off_grid
		while falling_off_grid:
			virtual_slot.tiles.append(slot_above.tile)
			slot_above.tile = null
			
			slot_above = board.get_slot_above(slot_above)
			if slot_above != null and not slot_above.is_empty():
				tile = slot_above.tile
				falling_off_grid = tile.falling_off_grid
			else:
				falling_off_grid = false

	var slots_to_update = []
	for i in columns:
		var virtual_slot = board.slots[rows][i]
		if not virtual_slot.tiles.empty():
			slots_to_update.append(virtual_slot)

	return slots_to_update

func _reset_cell_to_spawn_in_columns():
	for i in board.columns:
		tile_to_spawn_in_column[i] = 0

func replace_slot_with_cell_above(slot: Slot) -> Array:
	if not slot.is_empty():
		return []
		
	var slots_to_update = []

	var current_slot = slot
	var slot_above = board.get_slot_above(slot)
	while slot_above != null:
		if not slot_above.is_empty():
			_put_tile_to_slot(slot_above.tile, current_slot)
			slots_to_update.append(current_slot)
			slot_above.tile = null
			current_slot = slot_above
			slot_above = board.get_slot_above(current_slot)
		else:
			slot_above = board.get_slot_above(slot_above)

	if current_slot.is_empty():
		var tile = TileFactory.create_random_tile(self)
		var coordinates = board.get_slot_col_row(current_slot)
		tile_to_spawn_in_column[coordinates.col] += 1
		var spawn_row = -tile_to_spawn_in_column[coordinates.col]
		set_slot_position_and_scale(tile, coordinates.col, spawn_row)
		_put_tile_to_slot(tile, current_slot)
		slots_to_update.append(current_slot)
	
	return slots_to_update

func are_slots_neighbours(slot: Slot, slot2: Slot) -> bool:
	var coordinates = board.get_slot_col_row(slot)
	var coordinates2 = board.get_slot_col_row(slot2)
	if coordinates.col == coordinates2.col and abs(coordinates.row - coordinates2.row) == 1:
		return true
	if coordinates.row == coordinates2.row and abs(coordinates.col - coordinates2.col) == 1:
		return true
	return false


func _on_Viewport_size_changed():
	for i in board.rows:
		for j in board.columns:
			var slot = board.slots[i][j]
			set_slot_position_and_scale(slot, j, i)
			if not slot.is_empty():
				set_slot_position_and_scale(slot.tile, j, i)
	
func _put_tile_to_slot(tile: Tile, slot: Slot):
	slot.tile = tile
	
	if tile.is_connected("input_event", self, "_on_tile_input_event"):
		tile.disconnect("input_event", self, "_on_tile_input_event")
	
	var err = tile.connect("input_event", self, "_on_tile_input_event", [slot])
	assert(err == 0)

func _update_slot(slot: Slot):
	_slots_updating_number += 1
	slot.update_tile()

func _on_slot_updated(slot: Slot):
	_slots_updating_number -= 1
	if _slots_updating_number == 0:
		_check_if_game_is_over()
		ScoreCounter.check_if_game_is_over()
		emit_signal("updated")

class_name Board

signal slot_created

var rows: int
var columns: int
var spacing = 2

var slots = []

func _init(rows_num: int = 8, columns_num: int = 8):
	rows = rows_num
	columns = columns_num

	for i in rows:
		slots.append([])

func prepare_slots(slot_resource: Resource):
	for i in rows:
		for j in columns:
			var slot = slot_resource.instance()
			slot.row = i
			slot.col = j
			slots[i].append(slot)
			emit_signal("slot_created", slot, i, j)

func get_slot_col_row(slot: Slot) -> Coordinates:
	for i in rows:
		for j in columns:
			if slots[i][j] == slot:
				return Coordinates.new(j, i)

	return null

func get_slot_to_left(slot: Slot) -> Slot:
	var coordinates = get_slot_col_row(slot)
	if coordinates != null and coordinates.col - 1 > -1:
		return slots[coordinates.row][coordinates.col - 1]

	return null

func get_slot_to_right(slot: Slot) -> Slot:
	var coordinates = get_slot_col_row(slot)
	if coordinates != null and coordinates.col + 1 < columns:
		return slots[coordinates.row][coordinates.col + 1]

	return null

func get_slot_above(slot: Slot) -> Slot:
	var coordinates = get_slot_col_row(slot)
	if coordinates != null and coordinates.row - 1 > -1:
		return slots[coordinates.row - 1][coordinates.col]

	return null

func get_slot_below(slot: Slot) -> Slot:
	var coordinates = get_slot_col_row(slot)
	if coordinates != null and coordinates.row + 1 < rows:
		return slots[coordinates.row + 1][coordinates.col]

	return null
		

class_name PathFinder

var board: Board
var paths = []

func _init(board: Board):
	self.board = board
	

func get_longest_path(slot: Slot) -> Array: 
	paths = []
	find_longest_path(slot)
	return paths[0].duplicate()


func find_longest_path(slot: Slot, path: Array = []):
	path.append(slot)

	var other_slot = board.get_slot_to_left(slot)
	if other_slot != null and other_slot.has_same_color(slot) and path.find(other_slot) == -1:
		find_longest_path(other_slot, path)
	

	other_slot = board.get_slot_above(slot)
	if other_slot != null and other_slot.has_same_color(slot) and path.find(other_slot) == -1:
		find_longest_path(other_slot, path)
	

	other_slot = board.get_slot_to_right(slot)
	if other_slot != null and other_slot.has_same_color(slot) and path.find(other_slot) == -1:
		find_longest_path(other_slot, path)
	

	other_slot = board.get_slot_below(slot)
	if other_slot != null and other_slot.has_same_color(slot) and path.find(other_slot) == -1:
		find_longest_path(other_slot, path)
	
	var longest_path_size = longest_path_size()
	if path.size() > longest_path_size:
		paths.append(path.duplicate())
		delete_shorter_paths(path.size())
	
	path.pop_back()

func find_path_of_length(slot: Slot, length: int, path: Array = []):
	path.append(slot)
	
	if path.size() >= length:
		return path

	var other_slot = board.get_slot_to_left(slot)
	if other_slot != null and other_slot.has_same_color(slot) and path.find(other_slot) == -1:
		var result = find_path_of_length(other_slot, length, path)
		if result != null:
			return result
	

	other_slot = board.get_slot_above(slot)
	if other_slot != null and other_slot.has_same_color(slot) and path.find(other_slot) == -1:
		var result = find_path_of_length(other_slot, length, path)
		if result != null:
			return result
	

	other_slot = board.get_slot_to_right(slot)
	if other_slot != null and other_slot.has_same_color(slot) and path.find(other_slot) == -1:
		var result = find_path_of_length(other_slot, length, path)
		if result != null:
			return result
	

	other_slot = board.get_slot_below(slot)
	if other_slot != null and other_slot.has_same_color(slot) and path.find(other_slot) == -1:
		var result = find_path_of_length(other_slot, length, path)
		if result != null:
			return result
	
	path.pop_back()

func delete_shorter_paths(longest_path_size: int):
	var newPaths = []
	for path in paths: 
		if path.size() == longest_path_size:
			newPaths.append(path)
	

	paths = newPaths


func longest_path_size()-> int: 
	var max_length = 0
	for path in paths: 
		max_length = max(path.size(), max_length)
	

	return max_length

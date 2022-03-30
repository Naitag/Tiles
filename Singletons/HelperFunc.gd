extends Node

func get_formated_number(number: int) -> String:
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res

func to_dict(node: Node) -> Dictionary:
	var node_dict = inst2dict(node)
	for k in node_dict.keys():
		var key = k as String
		if key.begins_with("@"):
			continue

		var property_value = node[key]
		if property_value is Enum:
			node_dict[key] = property_value.to_dict()
		elif property_value is Node:
			node_dict[key] = to_dict(property_value)
		elif property_value is Array:
			var array = []
			for property_value_item in property_value:
				if property_value_item is Node:
					array.append(to_dict(property_value_item))
				else:
					array.append(property_value_item)
			node_dict[key] = array
		else:
			node_dict[key] = property_value
			
	return node_dict

func from_dict(node_dict: Dictionary) -> Node:
	if node_dict["@path"] == "res://Classes/TileModifierOption.gd":
		var kind = Enum.from_dict(node_dict["kind"])
		var type = Enum.from_dict(node_dict["type"])
		return TileModifierOption.new(kind, type, node_dict["chance"])

	var node = dict2inst(node_dict)
	for k in node_dict.keys():
		var key = k as String
		if key.begins_with("@"):
			continue

		var node_dict_value = node_dict[key]
		if node_dict_value is Dictionary:
			if node_dict_value.has("_class"):
				node[key] = Enum.from_dict(node_dict_value)
			elif node_dict_value.has("@path"):
				node[key] = from_dict(node_dict_value)
		elif node_dict_value is Array:
			var array = []
			for node_dict_value_item in node_dict_value:
				if node_dict_value_item is Dictionary:
					array.append(from_dict(node_dict_value_item))
				else:
					array.append(node_dict_value_item)
			node[key] = array
		else:
			node_dict[key] = node_dict_value
			
	return node

func load_from_file(file_path: String) -> Array:
	var result = []
	var file = File.new()
	if not file.file_exists(file_path):
		return result
	
	file.open(file_path, File.READ)
	var file_line = file.get_as_text()
	if file_line == "":
		return result
	
	var array = parse_json(file_line)
	for dict in array:
		var data = HelperFunc.from_dict(dict)
		result.append(data)

	file.close()
	return result

func save_to_file(file_path: String, array: Array):
	var file = File.new()
	file.open(file_path, File.WRITE)
	
	var dict_array = []
	for item in array:
		if item is Node:
			var dict = HelperFunc.to_dict(item)
			dict_array.append(dict)
		else:
			dict_array.append(item)
	
	var json = JSON.print(dict_array, "  ", true)
	file.store_string(json)
	file.close()

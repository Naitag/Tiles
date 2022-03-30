class_name Coordinates

var col
var row

func _init(col, row):
	self.col = col
	self.row = row

func _to_string():
	return "col: " + str(col) + " row: " + str(row)

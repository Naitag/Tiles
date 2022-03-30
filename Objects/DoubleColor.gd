extends Sprite
class_name DoubleColor

var options: DoubleColorOptions

var color: TileColor

func _ready():
	texture = Constants.get_half_tile_texture(color)

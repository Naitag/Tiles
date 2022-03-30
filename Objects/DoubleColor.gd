extends TileModifier
class_name DoubleColor

var colors = []

func _init(type: TileModifierType):
	_kind = TileModifierKind.COLOR_MODIFIER
	_type = type

func set_color(color: TileColor):
	texture = Constants.get_half_tile_texture(color)
	colors.append(color)
		
	centered = false

extends TileModifier
class_name ExtraMovesModifier

var quantity: int setget , get_quantity

func _init(type: TileModifierType):
	_kind = TileModifierKind.EXTRA_MOVES
	_type = type
	if type == TileModifierType.EXTRA_MOVES_2:
		quantity = 2
	elif type == TileModifierType.EXTRA_MOVES_3:
		quantity = 3
	elif type == TileModifierType.EXTRA_MOVES_4:
		quantity = 4
	elif type == TileModifierType.EXTRA_MOVES_5:
		quantity = 5

	centered = false
	texture = Textures.get_extra_moves_textures()[type.get_idn()]
	z_index = 1

func modify_number_of_moves(number_of_moves: int) -> int:
	return number_of_moves + quantity
	
func get_quantity() -> int:
	return quantity

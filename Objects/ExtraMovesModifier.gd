extends Sprite
class_name ExtraMovesModifier

var options: ExtraMovesModifierOptions

func _ready():
	texture = Textures.get_extra_moves_textures()[options.quantity]
	z_index = 1

func modify_number_of_moves(number_of_moves: int) -> int:
	return number_of_moves + options.quantity
	
func get_quantity() -> int:
	return options.quantity

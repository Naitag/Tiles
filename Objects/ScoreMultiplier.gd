extends TileModifier
class_name ScoreMultiplier

const TYPE = "ScoreMultiplier"
var _quantity: int setget , get_quantity

func _init(type: TileModifierType):
	_kind = TileModifierKind.SCORE_MULTIPLIER
	_type = type
	if type == TileModifierType.SCORE_MULTIPIER_X2:
		_quantity = 2
	elif type == TileModifierType.SCORE_MULTIPIER_X3:
		_quantity = 3
	elif type == TileModifierType.SCORE_MULTIPIER_X4:
		_quantity = 4
	elif type == TileModifierType.SCORE_MULTIPIER_X5:
		_quantity = 5

	centered = false
	texture = Textures.get_score_multiplier_textures()[type.get_idn()]
	z_index = 1

func modify_score(score: int) -> int:
	return score * _quantity
	
func get_quantity() -> int:
	return _quantity

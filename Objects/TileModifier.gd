extends Sprite
class_name TileModifier

var _kind: TileModifierKind setget , get_kind
var _type: TileModifierType setget , get_type

func get_kind():
	return _kind

func get_type():
	return _type

func modify_score(score: int) -> int:
	assert(1==0, "func must be overritten")
	return 0

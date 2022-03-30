extends Node
class_name TileModifierOption

var kind: TileModifierKind
var type: TileModifierType
var chance: float

func _init(kind_: TileModifierKind, type_: TileModifierType, chance_: float):
	kind = kind_
	type = type_
	chance = chance_

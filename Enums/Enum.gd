extends Node
class_name Enum

var _idn: String setget ,get_idn
var _enum_name: String

func get_idn() -> String:
	return _idn

static func create(idn_: String, enum_name_: String):
	var e = .get_script().new()
	e._idn = idn_
	e._enum_name = enum_name_
	return e

func to_dict() -> Dictionary:
	return {
		"_idn": _idn,
		"_enum_name": _enum_name
	}
	
static func from_dict(dict: Dictionary):
	if dict["_enum_name"] == "TileColor":
		if dict["_idn"] == "RED":
			return TileColor.RED
		elif dict["_idn"] == "GREEN":
			return TileColor.GREEN
		elif dict["_idn"] == "BLUE":
			return TileColor.BLUE
		elif dict["_idn"] == "YELLOW":
			return TileColor.YELLOW
		elif dict["_idn"] == "GREY":
			return TileColor.GREY
	elif dict["_enum_name"] == "TileModifierKind":
		if dict["_idn"] == "SCORE_MULTIPLIER":
			return TileModifierKind.SCORE_MULTIPLIER
		elif dict["_idn"] == "COLOR_MODIFIER":
			return TileModifierKind.COLOR_MODIFIER
		elif dict["_idn"] == "EXTRA_MOVES":
			return TileModifierKind.EXTRA_MOVES
	elif dict["_enum_name"] == "TileModifierType":
		if dict["_idn"] == "SCORE_MULTIPIER_X2":
			return TileModifierType.SCORE_MULTIPIER_X2
		elif dict["_idn"] == "SCORE_MULTIPIER_X3":
			return TileModifierType.SCORE_MULTIPIER_X3
		elif dict["_idn"] == "SCORE_MULTIPIER_X4":
			return TileModifierType.SCORE_MULTIPIER_X4
		elif dict["_idn"] == "SCORE_MULTIPIER_X5":
			return TileModifierType.SCORE_MULTIPIER_X5
		elif dict["_idn"] == "DOUBLE_COLOR":
			return TileModifierType.DOUBLE_COLOR
		elif dict["_idn"] == "EXTRA_MOVES_2":
			return TileModifierType.EXTRA_MOVES_2
		elif dict["_idn"] == "EXTRA_MOVES_3":
			return TileModifierType.EXTRA_MOVES_3
		elif dict["_idn"] == "EXTRA_MOVES_4":
			return TileModifierType.EXTRA_MOVES_4
		elif dict["_idn"] == "EXTRA_MOVES_5":
			return TileModifierType.EXTRA_MOVES_5

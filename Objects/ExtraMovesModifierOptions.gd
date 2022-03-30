extends Node
class_name ExtraMovesModifierOptions

var quantity

static func create(quantity_: int) -> ExtraMovesModifierOptions:
	var instance = Scripts.extra_moves_modifier_options_script.new() as ExtraMovesModifierOptions
	instance.quantity = quantity_
	
	return instance

extends Node
class_name ScoreMultiplierOptions

var quantity: int

static func create(quantity_: int) -> ScoreMultiplierOptions:
	var instance = Scripts.score_multiplier_options_script.new() as ScoreMultiplierOptions
	instance.quantity = quantity_
	
	return instance

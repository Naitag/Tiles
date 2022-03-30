extends Sprite
class_name ScoreMultiplier

var options: ScoreMultiplierOptions

func _ready():
	var textures = Textures.get_score_multiplier_textures()
	texture = textures.get(options.quantity)
	z_index = 1

func modify_score(score: int) -> int:
	return score * options.quantity
	
func get_quantity() -> int:
	return options.quantity

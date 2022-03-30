extends Particles2D

enum DIRECTION {UP, DOWN, LEFT, RIGHT}

var direction: int
	
func _ready():
	process_material = process_material.duplicate()

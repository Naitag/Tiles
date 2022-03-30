extends Control

onready var stars = [
	$StarEmpty/StarYellow,
	$StarEmpty2/StarYellow,
	$StarEmpty3/StarYellow
]

func show_stars(number: int):
	for i in number:
		var timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.connect("timeout", self, "show_star", [i])
		timer.start(0.5 * (i + 1))

func show_star(i: int):
	stars[i].show()

func hide_stars():
	for i in stars.size():
		stars[i].hide()

	for child in get_children():
		if child is Timer:
			child.stop()

extends Node2D


var font

func _ready():
	font = DynamicFont.new()
	font.font_data = load("res://Fonts/DroidSans.ttf")
	font.size = 50
	
func _draw():
	draw_string(font, Vector2(10, 10), "test")

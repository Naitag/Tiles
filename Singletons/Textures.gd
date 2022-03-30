tool
extends Node

var _tile_textures
func get_tile_textures() -> Dictionary:
	if _tile_textures == null:
		_tile_textures = {
			"RED": load("res://Textures/TileRed.png") as StreamTexture,
			"GREEN": load("res://Textures/TileGreen.png") as StreamTexture,
			"BLUE": load("res://Textures/TileBlue.png") as StreamTexture,
			"YELLOW": load("res://Textures/TileYellow.png") as StreamTexture,
			"GREY": load("res://Textures/TileGrey.png") as StreamTexture,
		}

	return _tile_textures


var _half_tile_textures
func get_half_tile_textures() -> Dictionary:
	if _half_tile_textures == null:
		_half_tile_textures = {
			"RED": load("res://Textures/HalfTileRed.png"),
			"GREEN": load("res://Textures/HalfTileGreen.png"),
			"BLUE": load("res://Textures/HalfTileBlue.png"),
			"YELLOW": load("res://Textures/HalfTileYellow.png"),
		}
	
	return _half_tile_textures


var _button_textures
func get_button_textures() -> Dictionary:
	if _button_textures == null:
		_button_textures = {
			"RED": load("res://Textures/ButtonRed.png"),
			"GREEN": load("res://Textures/ButtonGreen.png"),
			"BLUE": load("res://Textures/ButtonBlue.png"),
			"YELLOW": load("res://Textures/ButtonYellow.png"),
			"GREY": load("res://Textures/ButtonGrey.png"),
		}
	
	return _button_textures


var _button_pressed_textures
func get_button_pressed_textures() -> Dictionary:
	if _button_pressed_textures == null:
		_button_pressed_textures = {
			"RED": load("res://Textures/ButtonPressedRed.png"),
			"GREEN": load("res://Textures/ButtonPressedGreen.png"),
			"BLUE": load("res://Textures/ButtonPressedBlue.png"),
			"YELLOW": load("res://Textures/ButtonPressedYellow.png"),
			"GREY": load("res://Textures/ButtonPressedGrey.png"),
		}
	
	return _button_pressed_textures

var _score_multiplier_textures
func get_score_multiplier_textures() -> Dictionary:
	if _score_multiplier_textures == null:
		_score_multiplier_textures = {
			2: load("res://Textures/ModifierTextx2White.png"),
			3: load("res://Textures/ModifierTextx3White.png"),
			4: load("res://Textures/ModifierTextx4White.png"),
			5: load("res://Textures/ModifierTextx5White.png"),
		}
		
	return _score_multiplier_textures
	
var _extra_moves_textures
func get_extra_moves_textures() -> Dictionary:
	if _extra_moves_textures == null:
		_extra_moves_textures = {
			2: load("res://Textures/ModifierText+2White.png"),
			3: load("res://Textures/ModifierText+3White.png"),
			4: load("res://Textures/ModifierText+4White.png"),
			5: load("res://Textures/ModifierText+5White.png"),
		}
	
	return _extra_moves_textures
	
var _arrow_modifier_textures
func get_arrow_modifier_texture() -> Dictionary:
	if _arrow_modifier_textures == null:
		_arrow_modifier_textures = {
			"UP": load("res://Textures/ArrowUpWhite.png"),
			"DOWN": load("res://Textures/ArrowDownWhite.png"),
			"LEFT": load("res://Textures/ArrowLeftWhite.png"),
			"RIGHT": load("res://Textures/ArrowRightWhite.png"),
		}
	
	return _arrow_modifier_textures

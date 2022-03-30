tool
extends Node

var DARK_RED = Color("a2222e")
var DARK_GREEN = Color("097f47")
var DARK_BLUE = Color("254787")

func get_tile_texture(color: TileColor) -> StreamTexture:
	return Textures.get_tile_textures().get(color.get_idn())

func get_half_tile_texture(color: TileColor) -> StreamTexture:
	return Textures.get_half_tile_textures().get(color.get_idn())

func get_button_texture(color: int) -> StreamTexture:
	var color_name = UiButton.COLORS.keys()[color]
	return Textures.get_button_textures().get(color_name)

func get_button_pressed_texture(color: int) -> StreamTexture:
	var color_name = UiButton.COLORS.keys()[color]
	return Textures.get_button_pressed_textures().get(color_name)

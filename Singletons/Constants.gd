tool
extends Node

var DARK_RED = Color("a2222e")
var DARK_GREEN = Color("097f47")
var DARK_BLUE = Color("254787")

onready var UP = Direction.create("UP")
onready var DOWN = Direction.create("DOWN")
onready var LEFT = Direction.create("LEFT")
onready var RIGHT = Direction.create("RIGHT")

onready var ALL_DIRECTIONS = [UP, DOWN, LEFT, RIGHT]

onready var RED = TileColor.create("RED")
onready var GREEN = TileColor.create("GREEN")
onready var BLUE = TileColor.create("BLUE")
onready var YELLOW = TileColor.create("YELLOW")
onready var GREY = TileColor.create("GREY")

onready var ALL_COLORS = [RED, GREEN, BLUE, YELLOW]

func get_tile_texture(color: TileColor) -> StreamTexture:
	return Textures.get_tile_textures().get(color.value)

func get_half_tile_texture(color: TileColor) -> StreamTexture:
	return Textures.get_half_tile_textures().get(color.value)

func get_button_texture(color: int) -> StreamTexture:
	var color_name = UiButton.COLORS.keys()[color]
	return Textures.get_button_textures().get(color_name)

func get_button_pressed_texture(color: int) -> StreamTexture:
	var color_name = UiButton.COLORS.keys()[color]
	return Textures.get_button_pressed_textures().get(color_name)

func get_arrow_modifier_texture(direction: String) -> StreamTexture:
	return Textures.get_arrow_modifier_texture()[direction]

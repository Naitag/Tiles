extends Control

onready var font = load("res://Fonts/normal_font.tres")
onready var container = $ScrollContainer/GridContainer
onready var template_texture_rect = $ScrollContainer/GridContainer/ExampleTextureRect
onready var template_label = $ScrollContainer/GridContainer/ExampleLabel
onready var template_description = $ScrollContainer/GridContainer/ExampleDescription

onready var templates = [template_description, template_label, template_texture_rect]

var descriptions = {
	TileModifierKind.SCORE_MULTIPLIER: "Adds a multiplier to the current score",
	TileModifierKind.COLOR_MODIFIER: "Adds additional color to the tile",
	"LongSelectionMultiplierOption": "After 3 selections with %d or more tiles, adds a multiplier",
	TileModifierKind.EXTRA_MOVES: "Adds extra moves"
}

func load_modifiers(level: Level):
	for child in container.get_children():
		if templates.find(child) == -1:
			child.queue_free()
	_load_tile_modifiers(level)
	_load_long_selection_modifiers(level)
		
func _load_tile_modifiers(level: Level):
	var game_options = level.game_options
	for modifier_option in game_options.tile_modifiers:
		var tile = _create_tile_with_modifier(modifier_option)
		container.add_child(tile)
		
		var label = template_description.duplicate()
		label.show()
		label.text = descriptions[modifier_option.kind]
		container.add_child(label)
		
func _create_tile_with_modifier(modifier_option: TileModifierOption) -> TextureRect:
	var tile_texture = Constants.get_tile_texture(TileColor.BLUE)
	var tile = template_texture_rect.duplicate()
	tile.show()
	tile.texture = tile_texture
	
	var modifier_texture
	if modifier_option.kind == TileModifierKind.SCORE_MULTIPLIER:
		modifier_texture = Textures.get_score_multiplier_textures()[modifier_option.type.get_idn()]
	elif modifier_option.kind == TileModifierKind.COLOR_MODIFIER:
		modifier_texture = Textures.get_half_tile_textures()[TileColor.RED.get_idn()]
	elif modifier_option.kind == TileModifierKind.EXTRA_MOVES:
		modifier_texture = Textures.get_extra_moves_textures()[modifier_option.type.get_idn()]
		
	var modifier = TextureRect.new()
	modifier.texture = modifier_texture
		
	tile.add_child(modifier)
	
	return tile

func _load_long_selection_modifiers(level: Level):
	var game_options = level.game_options
	for lsm in game_options.long_selection_multipliers:
		var lsm_option = lsm as LongSelectionMultiplierOption
		
#		var texture_rect = template_texture_rect.duplicate()
#		texture_rect.show()
	
		var modifier = template_label.duplicate()
		modifier.show()
		modifier.text = "X %d" % lsm_option.multiplier
#		texture_rect.add_child(modifier)
		container.add_child(modifier)
		
		var description = template_description.duplicate()
		description.show()
		description.text = descriptions["LongSelectionMultiplierOption"] % lsm_option.number_of_selected_tiles
		container.add_child(description)

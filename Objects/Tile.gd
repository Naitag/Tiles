extends Area2D
class_name Tile

onready var sprite = get_node("Sprite")

var _modifiers = []
var colors = []

var _disabled = false
var falling_off_grid = false

func select():
	for child in get_children():
		if child is Sprite:
			child.set_modulate(Color(2, 2, 2))
	
func deselect():
	for child in get_children():
		if child is Sprite:
			child.set_modulate(Color(1, 1, 1))

func set_color(color: TileColor):
	$Sprite.texture = Constants.get_tile_texture(color)
	$Particles2D.process_material = $Particles2D.process_material.duplicate()
	$Particles2D.process_material.set_shader_param("sprite", $Sprite.texture)
	colors.append(color)

func add_modifier(modifier: TileModifier):
	_modifiers.append(modifier)
	if modifier is DoubleColor:
		colors.append_array(modifier.colors)
	$Sprite.add_child(modifier)

func set_unique_modifier(modifier: UniqueModifier):
	_modifiers = [modifier]
	colors = []
	_disabled = modifier.disable_tile_selection
	falling_off_grid = modifier.falling_off_grid
	set_color(modifier.color)
	add_child(modifier)
	
func get_modifiers() -> Array:
	return _modifiers
	
func is_disabled() -> bool:
	return _disabled
	
func destroy():
	$Sprite.hide()
	var lifetime = $Particles2D.lifetime
	var explosiveness = $Particles2D.explosiveness
	$Particles2D.emitting = true
	get_tree().create_timer(lifetime * (2 - explosiveness), false).connect("timeout", self, "_destroy")
	
func _destroy():
	queue_free()

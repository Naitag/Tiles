extends Area2D
class_name Tile

onready var sprite = get_node("Sprite")

var colors = []
var selected = false

var _disabled = false
var falling_off_grid = false

func select():
	selected = true
	$Sprite.set_modulate(Color(2, 2, 2))
	for child in $Modifiers.get_children():
		if child is Sprite:
			child.set_modulate(Color(2, 2, 2))
		elif child.has_method("select"):
			child.select()
	
func deselect():
	selected = false
	$Sprite.set_modulate(Color(1, 1, 1))
	for child in $Modifiers.get_children():
		child.set_modulate(Color(1, 1, 1))
		if child.has_method("deselect"):
			child.deselect()
			
func hide():
	monitorable = false
	$Sprite.hide()
	for child in $Modifiers.get_children():
		child.hide()

func set_color(color: TileColor):
	$Sprite.texture = Constants.get_tile_texture(color)
	$Particles2D.process_material = $Particles2D.process_material.duplicate()
	$Particles2D.process_material.set_shader_param("sprite", $Sprite.texture)
	colors.append(color)
	
func add_modifier(modifier: Node):
	$Modifiers.add_child(modifier)
	
func get_modifiers() -> Array:
	return $Modifiers.get_children()
	
func is_disabled() -> bool:
	return _disabled

func get_modifiers_of_type(interface: Script) -> Array:
	var result = []
	for modifier in $Modifiers.get_children():
		if modifier is interface:
			result.append(modifier)

	return result

func destroy():
	hide()
	var lifetime = $Particles2D.lifetime
	var explosiveness = $Particles2D.explosiveness
	$Particles2D.emitting = true
	get_tree().create_timer(lifetime * (2 - explosiveness), false).connect("timeout", self, "_destroy")
	
func _destroy():
	queue_free()

func get_random_color_not_in_tile() -> TileColor:
	var colors_availible = []
	for i in Constants.ALL_COLORS.size():
		if i >= Options.current_level.game_options.number_of_tile_colors:
			break
		
		colors_availible.append(Constants.ALL_COLORS[i])
		
	for color in colors:
		colors_availible.erase(color)

	var i = randi() % colors_availible.size()
	return colors_availible[i]

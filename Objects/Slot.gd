extends Sprite
class_name Slot

signal updated

var row
var col

var selected = false
var need_update = false
var tile: Tile
var tiles = []

var virtual = false

func _ready():
	$Tween.connect("tween_all_completed", self, "_on_tween_all_completed")
	$Tween.connect("tween_completed", self, "_on_tween_completed")

func select():
	selected = true
	tile.select()
	
func deselect():
	selected = false
	if tile != null:
		tile.deselect()

func has_same_color(slot: Slot):
	if slot.tile == null or tile == null:
		return false
	if is_disabled() or slot.is_disabled():
		return false
	var slot_colors = slot.tile.colors
	for tile_color in tile.colors:
		if slot_colors.find(tile_color) > -1:
			return true

	return false

func remove_tile():
	tile.destroy()
	tile = null

func is_empty():
	return tile == null
		
func update_tile():
	if tile != null:
		var animation_duration = _get_animation_duration(tile)
		$Tween.interpolate_property(tile, "position",
			tile.position, position, animation_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	for t in tiles:
		var animation_duration = _get_animation_duration(t)
		$Tween.interpolate_property(t, "position",
			t.position, position, animation_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)

	$Tween.start()
	
func is_disabled() -> bool:
	return tile != null and tile.is_disabled()
	
func _get_animation_duration(t: Tile) -> float:
	var gap = position.y - t.position.y
	if Options.is_test:
		return float(0)
	else:
		return gap / 130 / 4
	
func _on_tween_completed(t: Tile, key):
	if tiles.find(t) >= 0:
#		ScoreCounter.update(t)
		tiles.erase(t)
		t.destroy()

func _on_tween_all_completed():
	emit_signal("updated")

extends Area2D
class_name ArrowModifier

const end_signal_name = "animation_end"
signal animation_end

var triggered = false
var _off_grid_position: Vector2
var _go_back_vector: Vector2

var direction: Direction
var options: ArrowModifierOptions

func _ready():
	if direction.equals(Constants.UP):
		_go_back_vector = Vector2(0, 50)
		$Sprite.texture = Constants.get_arrow_modifier_texture("UP")
	elif direction.equals(Constants.DOWN):
		_go_back_vector = Vector2(0, -50)
		$Sprite.texture = Constants.get_arrow_modifier_texture("DOWN")
		$Particles2D.rotate(deg2rad(180))
		$Particles2D.process_material.set_shader_param("emmision_angle", 180)
	elif direction.equals(Constants.LEFT):
		_go_back_vector = Vector2(50, 0)
		$Sprite.texture = Constants.get_arrow_modifier_texture("LEFT")
		$Particles2D.rotate(deg2rad(270))
		$Particles2D.process_material.set_shader_param("emmision_angle", 270)
	elif direction.equals(Constants.RIGHT):
		_go_back_vector = Vector2(-50, 0)
		$Sprite.texture = Constants.get_arrow_modifier_texture("RIGHT")
		$Particles2D.rotate(deg2rad(90))
		$Particles2D.process_material.set_shader_param("emmision_angle", 90)

func trigger(off_grid_slot_position: Vector2):
	triggered = true
	monitorable = true
	z_index = 10
	_off_grid_position = off_grid_slot_position
	if not Options.is_test:
		_go_back()
		yield($Tween, "tween_completed")
		$Particles2D.emitting = true
	_go_forward()
	yield($Tween, "tween_completed")
	monitorable = false
	hide()
	emit_signal("animation_end")

func select():
	$Sprite.set_modulate(Color(2, 2, 2))
	
func deselect():
	$Sprite.set_modulate(Color(1, 1, 1))

func _go_back():
	var time = 0.3
	$Tween.interpolate_property($Sprite, "position", Vector2.ZERO, _go_back_vector, time, Tween.TRANS_EXPO)
	$Tween.start()
	
func _go_forward():
	var time = 0.6
	$Tween.interpolate_property(self, "global_position", global_position, _off_grid_position, time, Tween.TRANS_EXPO)
	$Tween.interpolate_property(self, "modulate", modulate, Color(1, 1, 1, 0), time, Tween.TRANS_LINEAR)
	$Tween.start()

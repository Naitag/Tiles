tool
extends TextureButton
class_name UiButton

signal button_up_not_ouside

var _block_button_up = false

enum COLORS {
	RED,
	GREEN,
	BLUE,
	YELLOW,
	GREY
}

export(COLORS) var _color = COLORS.RED setget set_color
export(String) var _text = "" setget set_text

func set_color(color: int):
	_color = color
	texture_normal = Constants.get_button_texture(color)
	texture_pressed = Constants.get_button_pressed_texture(color)
	
func set_text(text: String):
	_text = text
	$Label.text = _text


func _on_Button_button_up():
	if not _block_button_up:
		emit_signal("button_up_not_ouside")

func _on_Button_gui_input(event):
	var draw_mode = get_draw_mode()
	if draw_mode == DRAW_NORMAL or draw_mode == DRAW_HOVER:
		_block_button_up = true
	else:
		_block_button_up = false

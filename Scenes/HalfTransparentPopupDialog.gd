extends PopupDialog

signal on_close

func _on_HalfTransparentPopupDialog_gui_input(event):
	if event is InputEventScreenTouch:
		if not event.is_pressed():
			emit_signal("on_close")

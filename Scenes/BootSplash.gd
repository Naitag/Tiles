extends TextureRect

func _ready():
#	yield(get_tree().create_timer(1), "timeout")
	if OS.has_feature("Server"):
		print("starting server")
		SceneManager.change_scene("res://Dev_Folder/WebSocketServer.tscn")
	else:
		SceneManager.change_scene("res://Scenes/Menu.tscn")

func _on_BootSplash_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pass

extends Control

var _selected_level: Level
var _prev_finished_level: FinishedLevel

func _ready():
	var levels_info = LevelsManager.get_levels_info()
	for info in levels_info:
		var button = $Button.duplicate() as UiButton
		$ScrollContainer/VBoxContainer.add_child(button)
		button.set_meta("id", info.id)
		
		var level = LevelsManager.get_level(info.id)
		var finished_level = LevelsManager.get_finished_level(info.id)
		if _prev_finished_level and _prev_finished_level.number_of_stars == 0:
			button.set_color(UiButton.COLORS.GREY)
			if not OS.is_debug_build():
				button.disabled = true
		elif finished_level.number_of_stars == level.score_thresholds.size():
			button.set_color(UiButton.COLORS.YELLOW)
		elif finished_level.number_of_stars > 0:
			button.set_color(UiButton.COLORS.GREEN)
		button.set_text(info.level_name)
		button.mouse_filter = Control.MOUSE_FILTER_PASS
		button.show()
		
		button.connect("button_up_not_ouside", self, "_on_level_click", [info.id])
		
		_prev_finished_level = finished_level
		
	var button = $Button.duplicate() as UiButton
	button.set_color(UiButton.COLORS.BLUE)
	button.set_text("more coming soon")
	button.disabled = true
	button.show()
	$ScrollContainer/VBoxContainer.add_child(button)
		
	var params = SceneManager.get_params()
	if params.has("open_level_id"):
		_on_level_click(params.open_level_id)

func _on_level_click(id):
	var level = LevelsManager.get_level(id)
	_selected_level = level
	$HalfTransparentPopupDialog/TextureRect/Label.text = level.level_name
	
#	$HalfTransparentPopupDialog/TextureRect/StarThresholdInfo.set_1_star_score(level.score_thresholds[0])
#	$HalfTransparentPopupDialog/TextureRect/StarThresholdInfo.set_2_star_score(level.score_thresholds[1])
#	$HalfTransparentPopupDialog/TextureRect/StarThresholdInfo.set_3_star_score(level.score_thresholds[2])
	
	$HalfTransparentPopupDialog/TextureRect/ModifiersList.load_modifiers(level)                 
	
	var finished_level = LevelsManager.get_finished_level(id)
	var number_of_stars = finished_level.number_of_stars
		
	$HalfTransparentPopupDialog.popup()
	yield(get_tree().create_timer(0.5), "timeout")
	$HalfTransparentPopupDialog/TextureRect/StarScene.show_stars(number_of_stars)


func _on_BackButton_button_up():
	SceneManager.change_scene("res://Scenes/Menu.tscn")

func _on_StartGameButton_button_up_not_ouside():
	LevelsManager.load_level(_selected_level.id)
	SceneManager.change_scene("res://Scenes/GameScene.tscn")	

func _on_HalfTransparentPopupDialog_on_close():
	_selected_level = null
	$HalfTransparentPopupDialog.hide()
	$HalfTransparentPopupDialog/TextureRect/StarScene.hide_stars()

extends Control

var columns = 8
var rows = 8
var slot_grid = []

onready var top_container = find_node("TopContainer") as Container
onready var viewport_container = find_node("ViewportContainer") as ViewportContainer
onready var bottom_container = find_node("BottomContainer") as CenterContainer

func _input(ev) -> void:
	get_viewport().unhandled_input(ev)

func _ready():
	_set_container_sizes()
	get_tree().get_root().connect("size_changed", self, "_set_container_sizes")
	ScoreCounter.connect("score_changed", self, "_on_score_changed")
	ScoreCounter.connect("moves_left_changed", self, "_on_moves_left_changed")
	ScoreCounter.connect("game_over", self, "_on_game_over")

func _set_container_sizes():
	var viewport: Viewport = get_viewport()
	var width = viewport.size.x
	var height = viewport.size.y

	var containers_ratio = (height - width) / 2

	top_container.size_flags_stretch_ratio = containers_ratio
	viewport_container.size_flags_stretch_ratio = width
	bottom_container.size_flags_stretch_ratio = containers_ratio

func _on_score_changed(score: int):
	$VBoxContainer/TopContainer/HBoxContainer/ScoreLabel.text = "Score: " + str(score)

func _on_moves_left_changed(moves_left: int):
	$VBoxContainer/TopContainer/HBoxContainer/MovesLeftLabel.text = "Moves left: " + str(moves_left)

func _on_game_over():
	$GameOverWindowDialog.popup()

func _on_GameOverWindowDialog_gui_input(event):
	if event is InputEventScreenTouch:
		SceneManager.change_scene("res://Menu.tscn")

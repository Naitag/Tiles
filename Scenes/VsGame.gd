extends Control
class_name VsGame

var id_value = ""
var owner_value = ""
var players_value = ""
onready var play_button: UiButton = $PlayButton

func _ready():
	$HBoxContainer/IdValueLabel.text = id_value
	$HBoxContainer2/OwnerValueLabel.text = owner_value
	$HBoxContainer3/PlayersValueLabel.text = players_value

func _on_CreateButton_button_up_not_ouside():
	pass # Replace with function body.

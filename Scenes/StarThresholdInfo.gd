extends Control

func set_star_scores(level: Level):
	set_1_star_score(level.score_thresholds[0])
	set_2_star_score(level.score_thresholds[1])
	set_3_star_score(level.score_thresholds[2])

func set_3_star_score(score: int):
	$VBoxContainer/HBoxContainer/ThreeStarLabel.text = HelperFunc.get_formated_number(score)

func set_2_star_score(score: int):
	$VBoxContainer/HBoxContainer2/TwoStarLabel.text = HelperFunc.get_formated_number(score)
	
func set_1_star_score(score: int):
	$VBoxContainer/HBoxContainer3/OneStarLabel.text = HelperFunc.get_formated_number(score)

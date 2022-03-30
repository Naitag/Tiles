extends Node

var _last_params = {}

var _baner_loaded = false

func _ready():
	MobileAds.connect("banner_loaded", self, "_on_banner_loaded")
	MobileAds.connect("banner_failed_to_load", self, "_on_banner_failed_to_load")

func change_scene(scene: String, params: Dictionary = {}):
	if not _baner_loaded and not OS.is_debug_build():
		MobileAds.load_banner()
	
	_last_params = params
	var err = get_tree().change_scene(scene)
	assert(err == 0)
	
func get_params() -> Dictionary:
	return _last_params

func _on_banner_loaded():
	_baner_loaded = true
	MobileAds.show_banner()

func _on_banner_failed_to_load(error):
	_baner_loaded = false

extends HBoxContainer

func _on_button_pressed() -> void:
	var lvl_dat: LevelData = load(Globals.LEVEL_PATH + $Label.text)
	print(Globals.LEVEL_PATH + $Label.text)
	get_tree().change_scene_to_packed(lvl_dat.level)

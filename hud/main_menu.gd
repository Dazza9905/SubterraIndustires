extends Control

func _on_load_game_button_up() -> void:
	get_tree().change_scene_to_packed(load("res://hud/level_picker.tscn"))

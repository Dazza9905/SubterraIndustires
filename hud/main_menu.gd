extends Control

func _ready() -> void:
	self.get_tree().paused = false


func _on_load_game_button_up() -> void:
	get_tree().change_scene_to_packed(load("res://hud/level_picker.tscn"))

extends Control

func _ready() -> void:
	self.get_tree().paused = false

func _on_begin_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://level1.tscn"))

extends Control

var load_progress: Array[int]
@export var level_picker: PackedScene
var tween
func _ready() -> void:
	self.get_tree().paused = false
	for i in range(0, 101):
		load_progress.append(i)

func _on_begin_pressed() -> void:
	GameManager.load_world("", 0)
	
func _on_load_game_pressed() -> void:
	get_tree().change_scene_to_packed(level_picker)

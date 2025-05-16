extends Button

@export var next_level_path: String 

func _ready() -> void:
	Globals.get_ObjectiveSystem().level_completed.connect(_on_level_completed)


func _on_level_completed() -> void:
	visible = true

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(load(next_level_path))

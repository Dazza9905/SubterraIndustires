extends Area2D
class_name FadeOutOnHover

@export var object_to_fade_out: CanvasItem


func _mouse_enter() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(object_to_fade_out, "modulate", Color(1, 1, 1, 0.2), 0.2)

func _mouse_exit() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(object_to_fade_out, "modulate", Color(1, 1, 1, 1), 0.2)
	

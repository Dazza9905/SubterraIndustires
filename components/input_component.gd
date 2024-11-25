@tool
extends IOComponent
class_name InputComponent


func _ready() -> void:
	if Engine.is_editor_hint():
		add_child(in_sprite)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

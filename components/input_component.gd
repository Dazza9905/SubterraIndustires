@tool
extends IOComponent
class_name InputComponent


func _ready() -> void:
	#if Engine.is_editor_hint():
	#add_child(in_sprite)
	print(self.name)

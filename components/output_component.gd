@tool
extends IOComponent
class_name OutputComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if Engine.is_editor_hint():aZ|
	#add_child(out_sprite)
	print(self.name)

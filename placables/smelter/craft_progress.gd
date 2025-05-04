#@tool
extends RotatableSprite2D
class_name CraftProgressIndicator

#@export var craft_comp: CrafterComponent
#
##func _ready() -> void:
	##craft_comp.craft_progress_changed.connect(_on_craft_progress_changed)
	#
#func _on_craft_progress_changed(progress: float):
	#print(progress)

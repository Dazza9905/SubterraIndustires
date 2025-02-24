extends Control
class_name GridObjectUI

@export var ui_components: Array[ComponentUI]

func link_all_ui_components(grid_object: GridObject):
	print("link all")
	var components: Array[Component] = grid_object.get_components()
	print(components)
	for ui_comp in ui_components:
		print("linking ", ui_comp.name)
		ui_comp.link_to_component(components)
		
		
func _on_close_button_pressed() -> void:
	Globals.get_UIS().close_building_ui()

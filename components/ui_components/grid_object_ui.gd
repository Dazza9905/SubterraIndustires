extends Control
class_name GridObjectUI


@export var ui_components: Array[Control]
@export var close_button: Button

func _ready() -> void:
	close_button.pressed.connect(close_ui)

func link_all_ui_components(grid_object: GridObject):
	print("link all")
	var components: Array[Component] = grid_object.get_components()
	for ui_comp in ui_components:
		print("linking ", ui_comp.name)
		ui_comp.link_to_component(components)
		
		
func close_ui() -> void:
	Globals.get_UIS().close_building_ui()

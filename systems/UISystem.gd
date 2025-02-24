extends Node
class_name UISystem

@export var ui_canvas: Control
var building_ui: GridObjectUI

func display_new_building_ui(new_ui: GridObjectUI):
	if building_ui:
		building_ui.queue_free()
	building_ui = new_ui
	
	ui_canvas.add_child(new_ui)
	
func close_building_ui() -> void:
	if building_ui:
		building_ui.queue_free()
	building_ui = null

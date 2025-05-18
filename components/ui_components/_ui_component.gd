extends Control
class_name ComponentUI

@export var ui_link_id: String


func link_to_component(components: Array[Component]) -> void:
	assert(false, "implement this method in child class")

func get_matching_comp(components: Array[Component]) -> Component:
	for comp in components:
		if comp.ui_link_id == ui_link_id:
			return comp
	assert(false, "UI Component did not link!")
	return null

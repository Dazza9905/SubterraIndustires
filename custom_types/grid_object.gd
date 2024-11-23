@icon("res://art/downloaded/icon_godot_node/node_2D/icon_crate.png")
class_name GridObject
extends StaticBody2D

var coordinates: Vector2i
var ocuppied_cells: Array[Vector2i]




func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func has_COMP_of_type(component_to_find) -> bool:
	if self.has_node("Components"):
		for component in $Components.get_children():
			if component == component_to_find:
				return true
		return false
	else: 
		return false

func connect_belt_component():
	if has_COMP_of_type(BeltComponent):
		for comp in $Components.get_children():
			if comp == BeltComponent:
				comp.
			
			

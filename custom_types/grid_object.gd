@icon("res://art/downloaded/icon_godot_node/node_2D/icon_crate.png")
class_name GridObject
extends StaticBody2D

var main_cell: Vector2i
var ocuppied_cells: Array[Vector2i]




func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _exit_tree() -> void:
	var parent = get_parent()
	if parent == GridReferenceSystem:
		var grid_ref_system: GridReferenceSystem = parent
		grid_ref_system.GO_destroyed(self)
	
func has_COMP_of_type(component_to_find) -> bool:
	if self.has_node("Components"):
		for component in $Components.get_children():
			if component == component_to_find:
				return true
		return false
	else: 
		return false

func connect_components():
	if has_node("Components:"):
		var compoenents: Array[Component] = $Components.get_children() as Array[Component]
		for comp in compoenents:
			comp.connect_to_tick()
	else:
		print(self.name, " has no components")
			
			

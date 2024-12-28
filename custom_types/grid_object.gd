@icon("res://art/downloaded/icon_godot_node/node_2D/icon_crate.png")
class_name GridObject
extends StaticBody2D

var main_cell: Vector2i
var ocuppied_cells: Array[Vector2i]

func _exit_tree() -> void:
	print("object deleted")
	var parent = get_parent()
	if parent is GridReferenceSystem:
		var grid_ref_system: GridReferenceSystem = parent
		for cell in ocuppied_cells:
			if grid_ref_system.reference_hashmap.erase(cell):
				print("Cell ", cell, " was deleted")
		grid_ref_system.print_dict()

func request_connection(calling_comp: IOComponent):
	# Look through all components and find IO component with valid parameters
	if has_node("Components:"):
		for comp in $Components.get_children():
			if IOComponent.are_diff(comp, calling_comp):
				print("Components are diff")
				if (IOComponent.facing_opposite_dir(comp, calling_comp)):
					print("Components are facing opposite direction")
					print("WE GOT CONNECTION!")
					(comp as IOComponent).IO_connection = calling_comp
					return comp
				else:
					print("aaaaaablelble")

func get_components():
	if has_node("Components:"):
		return $Components.get_children()
	else:
		print(self.name, "has no comps")
		return {}
	

func connect_components():
	if has_node("Components:"):
		var components: Array[Node] = $Components.get_children()
		for comp in components:
			(comp as Component).connect_to_tick()
	else:
		print(self.name, " has no components")
			
			

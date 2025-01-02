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

func request_connection(placed_comp: IOComponent):
	# Look through all components and find IO component with valid parameters
	if has_node("Components:"):
		for exist_comp in ($Components.get_children()):
		
			if (exist_comp is IOComponent):
				print("\tTESTING EXISTING ", exist_comp.get_io_info(), ":")
				if (exist_comp.accepts_conn_from(placed_comp)):
					print("\tWE GOT CONNECTION!")
					exist_comp.IO_connection = placed_comp
					return exist_comp
			else:
				print("\tTESTING EXISTING ", exist_comp.name, ":")
				print("\t\tIs not IOComponent")

func get_components():
	if has_node("Components:"):
		return $Components.get_children()
	else:
		print(self.name, "has no comps")
		return {}

func connect_components():
	if has_node("Components:"):
		var components := $Components.get_children()
		for comp in components:
			if comp is IOComponent:
				print("==JUST PLACED ", comp.get_io_info())
			else:
				print("==JUST PLACED ", comp.name, "==")
			(comp as Component).connect_to_tick()
	else:
		print(self.name, "has no components")
			
			

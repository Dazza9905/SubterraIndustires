@icon("res://art/downloaded/icon_godot_node/node_2D/icon_crate.png")
class_name GridObject
extends StaticBody2D

## the global XY of GO's main cell
var main_cell: Vector2i

var ocuppied_cells: Array[Vector2i]
@export var code_name: String

func _exit_tree() -> void:
	var grid_ref_system: GridReferenceSystem = Globals.get_GRS()
	if grid_ref_system:
		for cell in ocuppied_cells:
			if grid_ref_system.reference_hashmap.erase(cell):
				pass
				#print("Cell ", cell, " was deleted")
		#grid_ref_system.print_dict()
	#else:
		assert("Grid Reference system not found")
	

func request_connection(placed_comp: IOComponent):
	# Look through all components and find IO component with valid parameters
	if has_node("Components:"):
		for exist_comp in ($Components.get_children()):
		
			if (exist_comp is IOComponent):
				#print("\tTESTING EXISTING ", exist_comp.get_io_info(), ":")
				if (exist_comp.accepts_conn_from(placed_comp)):
					#print("\tWE GOT CONNECTION!")
					exist_comp.IO_connection = placed_comp
					return exist_comp
			#else:
				#print("\tTESTING EXISTING ", exist_comp.name, ":")
				#print("\t\tIs not IOComponent")

func get_components() -> Array[Component]:
	var components: Array[Component] = []
	if has_node("Components:"):
		for child in $Components.get_children():
			assert(child is Component, child.name + " is not a Component!")
			components.append(child)
	return components


func get_file_path() -> String:
	return Globals.PLACABLES_PATH + code_name + "/" + code_name
	
func GO_initialize() -> void:
	var epc = self.find_child("ExtraPlayerCollision")
	if epc is StaticBody2D:
		epc.process_mode = Node.PROCESS_MODE_INHERIT
	
	connect_components()
	
func connect_components():
	if has_node("Components:"):
		var components := $Components.get_children()
		for comp in components:
			#if comp is IOComponent:
				#print("==JUST PLACED ", comp.get_io_info())
			#else:
				#print("==JUST PLACED ", comp.name, "==")
			(comp as Component).connect_to_tick()
	#else:
		#print(self.name, "has no components")

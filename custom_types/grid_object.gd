@icon("res://art/downloaded/icon_godot_node/node_2D/icon_crate.png")
@tool
extends StaticBody2D
class_name GridObject


## the global XY of GO's main cell
var main_cell: Vector2i

var ocuppied_cells: Array[Vector2i]
@export var code_name: String
@export var init_after_place: Array[RotatableSprite2D]



@export_tool_button("View Right", "ArrowRight")
var view_right = func():
	rotation_degrees = 0
	update_sprites()
	
@export_tool_button("View Bottom", "ArrowDown")
var view_down = func():
	rotation_degrees = 90
	update_sprites()
	
@export_tool_button("View Left", "ArrowLeft")
var view_left = func():
	rotation_degrees = 180
	update_sprites()
	
@export_tool_button("View Up", "ArrowUp")
var view_up = func():
	rotation_degrees = -90
	update_sprites()


func _exit_tree() -> void:
	if not Engine.is_editor_hint():
		var grid_ref_system: GridReferenceSystem = Globals.get_GRS()
		if grid_ref_system:
			for cell in ocuppied_cells:
				if grid_ref_system.reference_hashmap.erase(cell):
					pass
					print("Cell ", cell, " was deleted")
			#grid_ref_system.print_dict()
		else:
			assert(false, "Grid Reference system not found")
	

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
			#if child is Component:
			#assert(child is Component, child.name + " is not a Component!")
			components.append(child as Component)

	return components


func get_file_path() -> String:
	return Globals.PLACABLES_PATH + code_name + "/" + code_name
	
#func _init() -> void:
	#view_right.call()
func _ready() -> void:
	if Engine.is_editor_hint():
		update_sprites()
	
func update_sprites() -> void:
	for node in init_after_place:
		#if node is RotatableSprite2D:
		node.GO_init()
	for comp in get_components():
		if comp is IOComponent:
			(comp as IOComponent).update_IO_port_view()
	
func GO_initialize() -> void:
	var epc := self.find_child("ExtraPlayerCollision")
	if epc is StaticBody2D:
		epc.process_mode = Node.PROCESS_MODE_INHERIT
		
	update_sprites()
	
	if not Engine.is_editor_hint():
		connect_components()
	
func connect_components() -> void:
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

@icon("res://art/downloaded/icon_godot_node/node_2D/icon_crate.png")
@tool
extends StaticBody2D
class_name GridObject


## the global XY of GO's main cell
var main_cell: Vector2i
var occuppied_cells: Array[Vector2i]

@export var self_packed_uid: String
@export var code_name: String
@export var init_after_place: Array[Node2D] = []:
	set(new_val):
		var allow_new = true
		if Engine.is_editor_hint():
			for node in new_val:
				if node is Node2D:
					if not node.has_method("GO_init"):
						#print(node.get_method_list())
						allow_new = false
						printerr("NODE DOES NOT IMPLEMNT GO_init()")
		if allow_new:
			init_after_place = new_val
#@export var ui_button: Button
var wannabe_rotation_degrees: float

@export_tool_button("View Right", "ArrowRight")
var view_right = func():
	rotation_degrees = 0
	wannabe_rotation_degrees = 0
	update_sprites()
@export_tool_button("View Bottom", "ArrowDown")
var view_down = func():
	rotation_degrees = 90
	wannabe_rotation_degrees = 90
	update_sprites()
@export_tool_button("View Left", "ArrowLeft")
var view_left = func():
	rotation_degrees = 180
	wannabe_rotation_degrees = 180
	update_sprites()
@export_tool_button("View Up", "ArrowUp")
var view_up = func():
	rotation_degrees = -90
	wannabe_rotation_degrees = -90
	update_sprites()
	
	
func _exit_tree() -> void:
	if not Engine.is_editor_hint():
		var grid_ref_system: GridReferenceSystem = Globals.get_GRS()
		if grid_ref_system:
			for cell in occuppied_cells:
				if grid_ref_system.reference_hashmap.erase(cell):
					pass
					#print("Cell ", cell, " was deleted")
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
	
#func _init() -> void:
	#view_right.call()
	
func _ready() -> void:
	if Engine.is_editor_hint():
		update_sprites()
	
func update_sprites() -> void:
	for node in init_after_place:
		if node is RotatableSprite2D:
			(node as RotatableSprite2D).GO_init()
		if node is AnimatedRotatableSprite2D:
			(node as AnimatedRotatableSprite2D).GO_init()
		if node is PresetsArea2D:
			(node as PresetsArea2D).GO_init()
	for comp in get_components():
		if comp is IOComponent:
			(comp as IOComponent).update_IO_port_view()
	
func GO_initialize() -> void:
	wannabe_rotation_degrees = rotation_degrees
	self.add_to_group("savable")
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

func serialize() -> Dictionary:
	var save_dict : Dictionary = {
		uid = var_to_str(self_packed_uid),
		position = var_to_str(position),
		rotation = var_to_str(rotation),
		main_cell = var_to_str(main_cell),
		occuppied_cells = var_to_str(occuppied_cells),
		components = []
	}
	for comp in get_components():
		save_dict.components.push_back(comp.serialize())
	#print(JSON.stringify(save_dict, "\t"))
	return save_dict
	
static func deserialize(go_data: Dictionary) -> GridObject:
	if str_to_var(go_data.uid) == "":
		push_warning("MISSING UID IN SAVE FILE")
		return null
		
	var packed_go = load(str_to_var(go_data.uid))
	assert(packed_go is PackedScene, "Could not load PackedScene of GridObject")
	
	var instance: GridObject = packed_go.instantiate() as GridObject
	assert(instance is GridObject, "Could not create GridObject instance")
		
	instance.position = str_to_var(go_data.position)
	instance.rotation = str_to_var(go_data.rotation)
	instance.main_cell = str_to_var(go_data.main_cell)
	instance.occuppied_cells = str_to_var(go_data.occuppied_cells)
	
	Globals.get_GRS().asign_GO_cells_to_GRS(instance)
	
	#if instance.ui_button:
		#instance.ui_button.mouse_filter = Control.MOUSE_FILTER_STOP
	for i_child in instance.get_children():
		if i_child is Control:
			(i_child as Control).mouse_filter = Control.MOUSE_FILTER_STOP
	
	var i = 0
	for comp in instance.get_components():
		#print("COMP DATA:", go_data.components[i])
		comp.deserialize(go_data.components[i])
		i += 1
		#print(i)
		
	return instance
	
	
func _on_button_pressed() -> void:
	serialize()

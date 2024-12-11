extends Node2D
class_name GridReferenceSystem
# - hold refernces to the objects
# - handles the operations when adding and removing objects from grid
# - signal connection


# - !IMPORTANT! GridObject only handles the:
#		function calling (of components),
#	for other pupouses modidy this script instead



var reference_hashmap: Dictionary

func GO_built(grid_object: GridObject):
	asign_GP_cells_to_GO(grid_object) #assign GridPostionerIndicator cells to GridObject
	asign_GO_cells_to_GRS(grid_object) #add GridObject.occupied_cells to the actuall GridHashmap
	connect_GO_to_GRS(grid_object)
	
	var GP_main_cell: Vector2i = Vector2(($"../GridPositioner".position.x - 16)/32, ($"../GridPositioner".position.y - 16)/32) as Vector2i
	grid_object.main_cell = GP_main_cell
	
	
	grid_object.connect_components()
	
	print_dict()

func GO_destroyed(grid_object: GridObject):
	var ocuppied_cells: Array[Vector2i] = grid_object.ocuppied_cells
	for cell in ocuppied_cells:
		reference_hashmap.erase(cell)
	print_dict()

func get_GO_from_XY(coordinates: Vector2i):
	if reference_hashmap.has(coordinates):
		
		return reference_hashmap[coordinates]
	else:
		return

func asign_GP_cells_to_GO(grid_object: GridObject):
	var GO_position: Vector2i
	GO_position.x = (grid_object.position.x - 16) / 32
	GO_position.y = (grid_object.position.y - 16) / 32
	
	#get indicators (for teir position)
	var collision_indicators = $"../GridPositioner/ManipulationParent/RuleCheckIndicatorManager".get_children()
	
	#for each indicator create a entry in dictionary
	for indicator in collision_indicators:
		#calcualte the coordinate for occupied cell
		var p_offset: Vector2i
		p_offset.x = indicator.position.x / 32
		p_offset.y = indicator.position.y / 32
		var coordinate: Vector2i = GO_position + p_offset
		#add it to the object
		grid_object.ocuppied_cells.append(coordinate)

func asign_GO_cells_to_GRS(grid_object: GridObject):
	for cell in grid_object.ocuppied_cells:
		reference_hashmap[cell] = grid_object

func connect_GO_to_GRS(grid_object: GridObject):
	grid_object.tree_exited.connect(GO_destroyed.bind(grid_object.ocuppied_cells))


func print_dict():
	for key in reference_hashmap.keys():
		var value = reference_hashmap[key]
		print("Key: ", key, " - Value: ", value)
	print("-------------")

extends Node
class_name GridReferenceSystem
# - hold refernces to the objects
# - handles the operations when adding and removing objects from grid
# - signal connection


# - !IMPORTANT! GridObject only handles the:
#		function calling (of components),
#	for other pupouses modidy this script instead



var reference_hashmap: Dictionary

func GO_built(grid_object: GridObject) -> void:
	asign_GP_cells_to_GO(grid_object) #assign GridPostionerIndicator cells to GridObject
	asign_GO_cells_to_GRS(grid_object) #add GridObject.occupied_cells to the actuall GridHashmap
	
	grid_object.main_cell = Globals.get_GP_cell_postion()
	grid_object.connect_components()
	
	print_dict()
	
func get_GO_from_XY(coordinates: Vector2i) -> GridObject:
	if reference_hashmap.has(coordinates):
		return reference_hashmap[coordinates]
	else:
		return

func asign_GP_cells_to_GO(grid_object: GridObject):
	var GO_position: Vector2i
	GO_position.x = (grid_object.position.x - (Globals.TILE_SIZE/2))/Globals.TILE_SIZE
	GO_position.y = (grid_object.position.y - (Globals.TILE_SIZE/2))/Globals.TILE_SIZE
	
	#get indicators (for teir position)
	var collision_indicators = $"../../World/GridPositioner/ManipulationParent/RuleCheckIndicatorManager".get_children()
	
	for indicator in collision_indicators:
		#calcualte the coordinate for occupied cell
		var p_offset: Vector2i
		p_offset.x = indicator.position.x / Globals.TILE_SIZE
		p_offset.y = indicator.position.y / Globals.TILE_SIZE
		#print("p_offset: ", p_offset)
		var coordinate: Vector2i = GO_position + GF.rotate(p_offset, $"../../World/GridPositioner/ManipulationParent".rotation)
		#add it to the object
		grid_object.ocuppied_cells.append(coordinate)

func asign_GO_cells_to_GRS(grid_object: GridObject):
	for cell in grid_object.ocuppied_cells:
		reference_hashmap[cell] = grid_object

#func connect_GO_to_GRS(grid_object: GridObject):
	#grid_object.tree_exited.connect(GO_destroyed.bind(grid_object.ocuppied_cells))


func print_dict():
	for key in reference_hashmap.keys():
		var value = reference_hashmap[key]
		print("Key: ", key, " - Value: ", value)
	print("-------------")

extends Node	

var grid_hashmap: Dictionary
	
func _on_build_succesfull(grid_object: GridObject):
	var position: Vector2i
	position.x = (grid_object.position.x - 16) / 32
	position.y = (grid_object.position.y - 16) / 32
	
	#get indicators (for teir position)
	var collision_indicators = $"../../World/GridPositioner/ManipulationParent/RuleCheckIndicatorManager".get_children()
	
	#for each indicator create a entry in dictionary
	for indicator in collision_indicators:
		#calcualte the coordinate for occupied cell
		var p_offset: Vector2i
		p_offset.x = indicator.position.x / 32
		p_offset.y = indicator.position.y / 32
		var coordinate: Vector2i = position + p_offset
		#add it to the object
		grid_object.ocuppied_cells.append(coordinate)
		
	for cell in grid_object.ocuppied_cells:
		grid_hashmap[cell] = grid_object
		
	print("added:")
	print_dict()
	
	
func _on_object_removed_from_grid(ocuppied_cells: Array[Vector2i]):
	for cell in ocuppied_cells:
		grid_hashmap.erase(cell)
		print(".")
	print("removed:")
	for key in grid_hashmap.keys():
		var value = grid_hashmap[key]
		print("Key: ", key, " - Value: ", value)
	print("removed<--")

func print_dict():
	for key in grid_hashmap.keys():
		var value = grid_hashmap[key]
		print("Key: ", key, " - Value: ", value)
	print("-------------")

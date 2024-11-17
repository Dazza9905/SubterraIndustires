extends Node	

var grid_hashmap: Dictionary = {"bannana": 1}
var x: int = 3


func _on_object_added_to_grid():
	grid_hashmap["asda"] = 3
	print(grid_hashmap["asda"])

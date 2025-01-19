extends CanvasLayer
class_name GridObjectUI

func get_GO_name() -> String:
	return get_parent().get_parent().code_name
	
func get_GO() -> GridObject:
	return get_parent().get_parent() as GridObject
	
func get_GO_componets():
	return get_GO().get_components()

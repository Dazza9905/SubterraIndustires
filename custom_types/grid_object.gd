@icon("res://art/downloaded/icon_godot_node/node_2D/icon_crate.png")
class_name GridObject
extends StaticBody2D

var coordinates: Vector2i
@export var ocuppied_cells: Array[Vector2i]

#signal _object_added_to_grid
signal _on_object_removed_from_grid

func _connect_to_reference_system():
	# Get the ReferenceSystem node using an absolute path
	var reference_system = get_node("/root/Game/Systems/ReferenceSystem")
	if reference_system:
		var call_add = Callable(reference_system, "_on_object_added_to_grid")
		var call_remove = Callable(reference_system, "_on_object_removed_from_grid")
		# FIXME: remove function from building_system.gd and use call_add
		# Connect the signal to the _on_object_ready function in ReferenceSystem
		#connect("_object_added_to_grid", call_add)
		connect("_on_object_removed_from_grid", call_remove)
	else:
		print("ReferenceSystem node not found!")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_connect_to_reference_system()
	
func _exit_tree() -> void:
	_connect_to_reference_system()
	_on_object_removed_from_grid.emit(self.ocuppied_cells)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

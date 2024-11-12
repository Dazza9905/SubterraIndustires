@icon("res://art/downloaded/icon_godot_node/node_2D/icon_crate.png")
class_name GridObject
extends StaticBody2D

var coordinates: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$/root/Gameplay/World/Dictionary.grid_hashmap[get_viewport().get_mouse_position()] = self
	print("---")
	print($/root/Gameplay/World/Dictionary.grid_hashmap)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

@icon("res://art/downloaded/icon_godot_node/node/icon_puzzle.png")
class_name Component
extends Node2D


# defines if component is active/passive
# active - updated from tick()
# example: Mover, Transormer, Generator, Destroyer 

# passive - updated and managed from other compoenents
# example: I/O, Slot/Buffer, Storage
var ads := RefCounted.new()
@export var part_of_GO: bool = true
var parent_GO: GridObject

@export var ui_link_id: String

func _ready() -> void:
	if part_of_GO:
		parent_GO = self.get_parent().get_parent()
	else:
		connect_to_tick()


#This parent class sould not be used as it is!
func get_parent_GO() -> GridObject:
	return self.get_parent().get_parent()

func update() -> void:
	assert(false, "The method 'update()' must be overridden in the child class.")

func connect_to_tick() -> void:
	assert(false, "The method 'connect_to_tick()' must be overridden in the child class.")

#func _ready() -> void:
	#print(self.name)

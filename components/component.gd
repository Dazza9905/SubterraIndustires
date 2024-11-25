@icon("res://art/downloaded/icon_godot_node/node/icon_puzzle.png")
class_name Component
extends Node


# defines if component is active/passive
# active - updated from tick()
# example: Mover, Transormer, Generator, Destroyer 

# passive - updated and managed from other compoenents
# example: I/O, Slot/Buffer, Storage
@export var active_component: bool = false # default: false

@onready var parent_GO: GridObject = self.get_parent().get_parent()


#This parent class sould not be used as it is!

func update():
	assert(false, "The method 'update()' must be overridden in the child class.")

func connect_to_tick():
	assert(false, "The method 'connect_to_tick()' must be overridden in the child class.")

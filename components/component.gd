@icon("res://art/downloaded/icon_godot_node/node/icon_puzzle.png")
class_name Component
extends Node


# defines if component is active/passive
# active - updated from tick()
# example: Mover, Transormer, Generator, Destroyer 

# passive - updated and managed from other compoenents
# example: I/O, Slot/Buffer, Storage
@export var active_component: bool = false # default: false

func update():
	if active_component:
		assert(false, "The method 'cupdate' must be overridden in the subcomponent. This parent class sould not be used as it is!
		Fix: overwithe the function with behivior that should happen when updated")
	else:
		pass

func connect_to_tick():
	if active_component:
		assert(false, "The method 'connect_to_tick' must be overridden in the subclass.
		Fix: overwithe the function with behivior that connects the object to a tick signal or pass if passive")
	else:
		pass

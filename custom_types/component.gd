@icon("res://art/downloaded/icon_godot_node/node/icon_puzzle.png")
class_name Component
extends Node


# defines if component is active/passive
# active - updated from tick()
# example: Mover, Transormer, Generator, Destroyer 

# passive - updated and managed from other compoenents
# example: I/O, Slot/Buffer, Storage
@export var active_component: bool = false # default: false

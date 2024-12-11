extends Node

const LEVEL_PATH = "res://levels/"

const TILE_SIZE = 32

enum SlotFlag {
	APPROVED,
	FULL,
	EMPTY,
	DIFF_TYPE,
	INVALID
}

#INPUTS HANDELING
func _input(event):
	if event is InputEventKey and event.pressed:
		if Input.is_action_pressed("debug_toggle_connections"):
			show_debug_io_conn = not show_debug_io_conn
			print("DEBUG - Show IO Connections: ", show_debug_io_conn)
		if Input.is_action_pressed("debug_toggle_io_ports"):
			show_debug_io_port = not show_debug_io_port
			print("DEBUG - Show IO Ports: ", show_debug_io_port)
			
			




#DEBUG FLAGS
var show_debug_io_conn: bool = false
var show_debug_io_port: bool = false

# explanations for short names in functions
# GO - GridObject
# GP - GridPositioner
# GRS - GridReferenceSystem
# COMP - Component
# OC - occupied_cells
# BP - BeltPath
# XY - coordinates	

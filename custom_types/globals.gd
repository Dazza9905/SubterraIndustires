extends Node

const LEVEL_PATH = "res://levels/"
const ITEM_TEX_PATH = "res://items/"
const ITEM_PATH = "res://items/"
const PLACABLES_PATH = "res://placables/"
const RECIPE_PATH = "res://recipes/"

const TILE_SIZE = 16

enum SlotFlag {
	APPROVED,
	FULL,
	EMPTY,
	DIFF_TYPE,
	INVALID
}


#INPUTS HANDELING
func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		if Input.is_action_pressed("debug_toggle_connections"):
			show_debug_io_conn = not show_debug_io_conn
			print("DEBUG - Show IO Connections: ", show_debug_io_conn)
		if Input.is_action_pressed("debug_toggle_io_ports"):
			show_debug_io_port = not show_debug_io_port
			print("DEBUG - Show IO Ports: ", show_debug_io_port)
		if Input.is_action_pressed("debug_toggle_belt_paths"):
			show_debug_belt_paths = not show_debug_belt_paths
			print("DEBUG - Show BeltPaths: ", show_debug_belt_paths)


func get_mode_building_system() -> BuildingSystem:
	return get_node("/root/Game/Systems/GBPluginSystems/BuildingSystem") as BuildingSystem
			

func get_tts() -> TimeTickSystem:
	return get_node("/root/Game/Systems/TimeTickSystem")
	
func get_GRS() -> GridReferenceSystem:
	return get_node("/root/Game/Systems/GridReferenceSystem")
	
func get_ObjectiveSystem() -> ObjectiveSystem:
	printerr(get_node("/root/Game/Systems/ObjectiveSystem").current_objective)
	return get_node("/root/Game/Systems/ObjectiveSystem")

func get_level_num() -> int:
	return get_node("/root/Game/Systems/LevelInfo").level_num


#DEBUG FLAGS
var show_debug_io_conn: bool = false
var show_debug_io_port: bool = false
var show_debug_belt_paths: bool = false

# explanations for short names in functions
# GO - GridObject
# GP - GridPositioner
# GRS - GridReferenceSystem
# COMP - Component
# OC - occupied_cells
# BP - BeltPath
# XY - coordinates	

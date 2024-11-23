extends Node

const LEVEL_PATH = "res://levels/"


enum SlotFlag {
	APPROVED,
	FULL,
	EMPTY,
	DIFF_TYPE,
	INVALID
}

@onready var ref_system = get_node("/root/Systems/TimeTickSystem")





# explanations for short names in functions
# GO - GridObject
# GP - GridPositioner
# GRS - GridReferenceSystem
# COMP - Component
# OC - occupied_cells
# BP - BeltPath

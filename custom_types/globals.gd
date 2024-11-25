extends Node

const LEVEL_PATH = "res://levels/"


enum SlotFlag {
	APPROVED,
	FULL,
	EMPTY,
	DIFF_TYPE,
	INVALID
}

@onready var grid_ref_system: GridReferenceSystem = get_node("/root/Game/World/GridReferenceSystem") as GridReferenceSystem
@onready var time_tick_system: TimeTickSystem = $Systems/TimeTickSystem
@onready var rule_check_indicator_manager: RuleCheckIndicatorManager = $World/GridPositioner/ManipulationParent/RuleCheckIndicatorManager




# explanations for short names in functions
# GO - GridObject
# GP - GridPositioner
# GRS - GridReferenceSystem
# COMP - Component
# OC - occupied_cells
# BP - BeltPath
# XY - coordinates	

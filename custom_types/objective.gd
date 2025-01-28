extends Resource
class_name Objective

@export var name: String
@export var sub_objectives: Array[SubObjective]
@export var next_objective: Objective
@export var level_complete: bool = false

func is_complete() -> bool:
	var is_completed = true
	for sub_objective in sub_objectives:
		if sub_objective.is_completed() == false:
			is_completed = false
	return is_completed

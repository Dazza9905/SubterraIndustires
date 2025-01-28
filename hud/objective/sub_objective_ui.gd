extends Label
class_name SubObjectiveUI

@export var sub_objective: SubObjective

func _init(pass_sub_objective: SubObjective) -> void:
	sub_objective = pass_sub_objective

func _process(delta: float) -> void:
	text = sub_objective.name + " " + str(sub_objective.current_completion) + "/" + str(sub_objective.finish_completion)

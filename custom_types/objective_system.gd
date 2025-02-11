extends Node
class_name ObjectiveSystem


@export var current_objective: Objective

signal objective_changed
signal level_completed

func complete_produce(item: Item,  amount: int = 1):
	for sub_objective in current_objective.sub_objectives:
		if sub_objective is SubObjectiveProduce:
			if (sub_objective as SubObjectiveProduce).item_to_produce.type == item.type:
				(sub_objective as SubObjectiveProduce).current_completion += amount
	switch_if_completed()

func complete_collect(item: Item, amount: int = 1):
	for sub_objective in current_objective.sub_objectives:
		if sub_objective is SubObjectiveCollect:
			if (sub_objective as SubObjectiveProduce).item_to_collect.type == item.type:
				(sub_objective as SubObjectiveProduce).current_completion += amount
	switch_if_completed()

func complete_task(id_name: String):
	for sub_objective in current_objective.sub_objectives:
		if sub_objective is SubObjectiveTask:
			if (sub_objective as SubObjectiveTask).id_name == id_name:
				(sub_objective as SubObjectiveTask).current_completion = 1
	switch_if_completed()


func switch_if_completed() -> void:
	print("switch")
	if current_objective:
		if current_objective.is_complete():
			if current_objective.next_objective is Objective:
				current_objective = current_objective.next_objective
				print("objective swithced")
				objective_changed.emit()
			else:
				print("level complete")
				level_completed.emit()

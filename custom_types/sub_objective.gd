extends Resource
class_name SubObjective

@export var name: String
@export var current_completion: int:
	set(new_completion):
		if new_completion < 0 :
			current_completion = 0
		else:
			current_completion = new_completion
@export var finish_completion: int

func is_completed() -> bool:
	return current_completion >= finish_completion

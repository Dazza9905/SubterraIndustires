extends Component
class_name ProgressComponent

signal completed
signal updated
signal reseted


@export var current: int:
	set(n_val):
		current = n_val
		updated.emit()
		if current >= goal:
			completed.emit()
			if auto_reset:
				current = 0
				reseted.emit()
@export var goal: int:
	set(n_val):
		if n_val <= 0:
			n_val = 1
		goal = n_val
@export var auto_reset: bool = false

func increment(amount: int = 1) -> void:
	current += amount

func reset() -> void:
	current = 0

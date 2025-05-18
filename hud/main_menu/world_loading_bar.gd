extends ProgressBar
class_name WorldLoadingBar

func _ready() -> void:
	visible = false
	max_value = 100

func _process(_delta: float) -> void:
	visible = bool(GameManager.load_progress)
	value = GameManager.load_progress*100

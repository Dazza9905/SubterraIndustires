extends Label
class_name BeltPathLabel

@export var belt_comp: BeltComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(belt_comp.belt_path.id) + "\n" + str(belt_comp.belt_path.path.rfind(belt_comp))

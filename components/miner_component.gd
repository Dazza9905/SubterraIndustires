extends Component
class_name MinerComp

@export var slot: SlotComponent
@export var area: Area2D

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)
	area.area_entered
	
	
func _on_machanine_tick() -> void:
	pass

extends Component
class_name CreativeTrashComp

@export var slot: SlotComponent


func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)
	#slot.slot_contents_changed.connect(delete_items) STACK OVERFLOW
	
	
func _on_machanine_tick() -> void:
	delete_items()
	
func delete_items() -> void:
	slot._amount = 0

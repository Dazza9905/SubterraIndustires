extends Component
class_name CreativeGenComp

@export var slot: SlotComponent
@export var item: Item

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)
	
	
func _on_machanine_tick() -> void:
	slot.give_item(item)

extends Component
class_name SpawnerComp

signal item_changed

@export var slot: SlotComponent
@export var item: Item:
	set(new_item):
		item = new_item
		slot._amount = 0
		slot.item = item
		slot._amount = 1
		item_changed.emit()

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)
	
	
func _on_machanine_tick() -> void:
	slot.give_item(item)

func serialize() -> Dictionary:
	var save_dict: Dictionary = {
		item = var_to_str(item)
	}
	
	return save_dict
	
func deserialize(load_dict: Dictionary) -> void:
	item = str_to_var(load_dict.item)

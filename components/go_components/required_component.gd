extends Component
class_name RequiredComponent 

signal status_changed

@export var slot: SlotComponent
@export var required: ItemStack
var is_passing: bool = false:
	set(new_val):
		if is_passing != new_val:
			is_passing = new_val
			status_changed.emit()

func connect_to_tick():
	slot.slot_contents_changed.connect(update_status)

func update_status():
	if slot.item == required.item or slot._amount >= required.amount:
		is_passing = true
	else:
		is_passing = false

extends Component
class_name CollectComponent

@export var what_to_collect: Item
@export var how_much_to_collect: int
@export var slot: SlotComponent
@export var auto_reset: bool = false
var fullfilled: bool = false:
	set(new_val):
		fullfilled = new_val
		if fullfilled == true:
			did_fullfill.emit()
			if auto_reset:
				reset()

signal did_fullfill

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(tick)

func tick():
	if slot.item == what_to_collect and slot._amount >= how_much_to_collect and not fullfilled:
		slot.take_sigle_type(what_to_collect.type, how_much_to_collect)
		fullfilled = true

func reset() -> void:
	fullfilled = false
	print("reset")

		

extends Component
class_name SplitterComponent

@export var inputs: Array[InputComponent]
@export var outputs: Array[OutputComponent]

var input_index: int = 0:
	set(new_index):
		input_index = new_index % inputs.size()
var output_index: int = 0:
	set(new_index):
		output_index = new_index % outputs.size()

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)
	
	
func _on_machanine_tick() -> void:
	#print("splitter ticked")
	var target_in_slot: SlotComponent
	var target_out_slot: SlotComponent
	
	for i in range(0, inputs.size()):
		if inputs[input_index].slot.is_empty():
			input_index += 1
		else:
			target_in_slot = inputs[input_index].slot
			output_index += 1

	for i in range(0, outputs.size()):
		if outputs[output_index].slot.is_empty():
			target_out_slot = outputs[output_index].slot
			output_index += 1
		else:
			output_index += 1
	
	#print(target_in_slot)
	#print(target_out_slot)
	if(target_in_slot is SlotComponent and target_out_slot is SlotComponent):
		var error: Error = target_out_slot.give_item(target_in_slot.item)
		print(error)
		if error == OK:
			target_in_slot.take()
	

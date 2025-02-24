extends Component
class_name ObjectiveCollect

@export var slots: Array[SlotComponent]
var objective_system: ObjectiveSystem

func connect_to_tick():
	Globals.get_tts().machine_tick.connect(_on_machine_tick)
	objective_system = Globals.get_ObjectiveSystem()
	

func _on_machine_tick():
	for slot in slots:
		var taken_item = slot.take()
		if taken_item: 
			objective_system.complete_collect(taken_item)

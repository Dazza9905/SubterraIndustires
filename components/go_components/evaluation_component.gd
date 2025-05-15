extends Component
class_name EvaluationComponent

@export var required_comps: Array[RequiredComponent]

signal status_changed

var is_passing: bool = false:
	set(new_val):
		if is_passing != new_val:
			is_passing = new_val
			status_changed.emit()

func connect_to_tick():
	for comp in required_comps:
		comp.status_changed.connect(update_status)

func update_status():
	var tmp_status: bool = true
	for comp in required_comps:
		if comp.is_passing == false:
			tmp_status = false
			is_passing = tmp_status

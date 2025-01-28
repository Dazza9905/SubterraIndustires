extends VBoxContainer
class_name ObjectiveUI


func _ready() -> void:
	Globals.get_ObjectiveSystem().objective_changed.connect(_on_objective_changed)
	$Label.text = Globals.get_ObjectiveSystem().current_objective.name
	for sub_objective in Globals.get_ObjectiveSystem().current_objective.sub_objectives:
		$VBoxContainer.add_child(SubObjectiveUI.new(sub_objective))


func _on_objective_changed() -> void:
	for child in $VBoxContainer.get_children():
		child.queue_free()
	if Globals.get_ObjectiveSystem().current_objective:
		$Label.text = Globals.get_ObjectiveSystem().current_objective.name
		for sub_objective in Globals.get_ObjectiveSystem().current_objective.sub_objectives:
			$VBoxContainer.add_child(SubObjectiveUI.new(sub_objective))
	

extends Control
class_name ObjectiveUI


@export var objective_label: Label
@export var sub_objectives_parent: Control
@export var objective_menu: Control


func _ready() -> void:
	Globals.get_ObjectiveSystem().objective_changed.connect(_on_objective_changed)
	if Globals.get_ObjectiveSystem().current_objective == null:
		printerr(":((")
	objective_label.text = Globals.get_ObjectiveSystem().current_objective.name
	for sub_objective in Globals.get_ObjectiveSystem().current_objective.sub_objectives:
		sub_objectives_parent.add_child(SubObjectiveUI.new(sub_objective))


func _on_objective_changed() -> void:
	for child in sub_objectives_parent.get_children():
		child.queue_free()
	if Globals.get_ObjectiveSystem().current_objective:
		objective_label.text = Globals.get_ObjectiveSystem().current_objective.name
		for sub_objective in Globals.get_ObjectiveSystem().current_objective.sub_objectives:
			sub_objectives_parent.add_child(SubObjectiveUI.new(sub_objective))
	


func _on_open_objectives_menu_button_pressed() -> void:
	if objective_menu.visible:
		objective_menu.visible = false
	else: 
		objective_menu.visible = true
	

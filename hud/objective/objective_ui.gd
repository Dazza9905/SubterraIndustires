extends Control
class_name ObjectiveUI


@export var objective_label: Label
@export var sub_objectives_parent: Control
@export var objective_menu: Control
@export var size_node: Control


func _ready() -> void:
	Globals.get_ObjectiveSystem().objective_changed.connect(_on_objective_changed)
	objective_label.text = Globals.get_ObjectiveSystem().current_objective.name
	for sub_objective in Globals.get_ObjectiveSystem().current_objective.sub_objectives:
		sub_objectives_parent.add_child(SubObjectiveUI.new(sub_objective))
	sub_objectives_parent.connect("child_order_changed", _on_sub_objective_children_changed)
	_on_sub_objective_children_changed()

func _on_sub_objective_children_changed() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(objective_menu, "custom_minimum_size", size_node.get_minimum_size(), 0.1)


func _on_objective_changed() -> void:
	for child in sub_objectives_parent.get_children():
		child.queue_free()
	if Globals.get_ObjectiveSystem().current_objective:
		objective_label.text = Globals.get_ObjectiveSystem().current_objective.name
		for sub_objective in Globals.get_ObjectiveSystem().current_objective.sub_objectives:
			sub_objectives_parent.add_child(SubObjectiveUI.new(sub_objective))
	_on_sub_objective_children_changed()
	


func _on_open_objectives_menu_button_pressed() -> void:
	if objective_menu.visible:
		var tween: Tween = create_tween().set_parallel(true)
		tween.set_ease(Tween.EASE_OUT_IN)
		tween.tween_property(objective_menu, "custom_minimum_size", Vector2(0, 0), 0.1)
		tween.tween_property(objective_menu, "modulate", Color(1,1,1,0), 0.1)
		tween.finished.connect(set_hidden)
		objective_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else: 
		objective_menu.visible = true
		var tween: Tween = create_tween().set_parallel(true)
		tween.set_ease(Tween.EASE_OUT_IN)
		tween.tween_property(objective_menu, "custom_minimum_size", size_node.get_minimum_size() + Vector2(0, 40), 0.1)
		tween.tween_property(objective_menu, "modulate", Color(1,1,1,1), 0.1)
		objective_menu.mouse_filter = Control.MOUSE_FILTER_STOP
	
func set_hidden() -> void:
	objective_menu.visible = false

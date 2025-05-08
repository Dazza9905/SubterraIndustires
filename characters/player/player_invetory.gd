extends Node
class_name PlayerInventory

@export var ui_view_parent: Control
@export var ui_componets: Array[ComponentUI]
var components: Array[Component]
@export var trash_comp: CreativeTrashComp

var is_open: bool = false:
	set(new_state):
		if(new_state != is_open):
			if(new_state == true):
				is_open = new_state
				_open_inventory()
			else:
				is_open = new_state
				_close_inventory()
		else:
			is_open = new_state

func _ready() -> void:
	update_slots()
	for ui_comp in ui_componets:
		ui_comp.link_to_component(components)
	trash_comp.connect_to_tick()

func _open_inventory() -> void:
	ui_view_parent.visible = true
	ui_view_parent.mouse_filter = Control.MOUSE_FILTER_STOP
	is_open = true
	
func _close_inventory() -> void:
	ui_view_parent.visible = false
	ui_view_parent.mouse_filter = Control.MOUSE_FILTER_IGNORE
	is_open = false
	
func toggle_inventory() -> void:
	is_open = not is_open

func update_slots() -> void:
	for child in get_children():
		if(child is SlotComponent):
			components.append(child)

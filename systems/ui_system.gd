extends Node
class_name UISystem

@export var ui_canvas: Control
var building_ui: GridObjectUI
@export var buildingUI_anim_player: AnimationPlayer

func display_new_building_ui(new_ui: PackedScene, grid_object: GridObject):
	if building_ui:
		building_ui.free()
	building_ui = new_ui.instantiate() as GridObjectUI
	building_ui.grid_object = grid_object
	ui_canvas.add_child(building_ui)
	(building_ui as GridObjectUI).link_all_ui_components(grid_object)
	
	buildingUI_anim_player.play("open_building_ui", -1, 1.0, false)
	
func close_building_ui() -> void:
	buildingUI_anim_player.play_backwards("open_building_ui")
	buildingUI_anim_player.animation_finished.connect(on_close_anim_finish, 4)
	
	
func on_close_anim_finish(anim_name: String) -> void:
	if building_ui:
		building_ui.free()
	building_ui = null

func toggle_inventory():
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if Input.is_action_pressed("toggle_esc_menu"):
			if ui_canvas.get_child_count() != 0:
				close_building_ui()

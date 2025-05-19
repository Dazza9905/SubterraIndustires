extends ComponentUI
class_name CoreDrillCompUI

var core_drill_comp: CoreDrillComp

@export var progress_bar: ProgressBar
@export var go_up_button: Button
@export var go_down_button: Button

func link_to_component(components: Array[Component]) -> void:
	core_drill_comp = get_matching_comp(components) as CoreDrillComp
	if core_drill_comp:
		core_drill_comp.drilled.connect(update)
	go_down_button.disabled = true
	update()
	
	match Globals.get_LevelInfo().current_floor:
		0:
			go_up_button.visible = false
			go_down_button.visible = true
		1:
			go_up_button.visible = true
			go_down_button.visible = true
		2:
			go_up_button.visible = true
			go_down_button.visible = false
			
func update():
	progress_bar.max_value = core_drill_comp.full_progress
	progress_bar.value = core_drill_comp.current_progress
	
	if core_drill_comp.current_progress >= core_drill_comp.full_progress:
		go_down_button.disabled = false
	

func _on_go_up_pressed() -> void:
	Globals.get_LevelInfo().current_floor -= 1
	GameManager.save_world()
	Globals.load_floor = Globals.get_LevelInfo().current_floor
	get_tree().change_scene_to_packed(preload("uid://dq0w7ijnukont"))


func _on_go_down_pressed() -> void:
	Globals.get_LevelInfo().current_floor += 1
	GameManager.save_world()
	Globals.load_floor = Globals.get_LevelInfo().current_floor
	get_tree().change_scene_to_packed(preload("uid://dq0w7ijnukont"))

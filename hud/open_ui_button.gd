extends Button
class_name OpenUIButton

func _ready() -> void:
	Globals.get_mode_building_system().mode_state.mode_changed.connect(_on_mode_changed)
	
func _on_mode_changed(building_mode: GBEnums.Mode) -> void:
	print(building_mode)
	if (building_mode == GBEnums.Mode.OFF):
		mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		mouse_filter = Control.MOUSE_FILTER_IGNORE

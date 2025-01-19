extends Button
class_name OpenUIButton

var ui_path: String

func _ready() -> void:
	Globals.get_mode_building_system().mode_state.mode_changed.connect(_on_mode_changed)
	ui_path = self.get_parent().get_file_path() + "_ui.tscn"
	
func _on_mode_changed(building_mode: GBEnums.Mode) -> void:
	print(building_mode)
	if (building_mode == GBEnums.Mode.OFF):
		mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		
func _pressed() -> void:
	var packed_ui = load(ui_path)
	var ui = packed_ui.instantiate()
	print(ui_path)
	add_child(ui)

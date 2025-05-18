extends Button
class_name OpenUIButton

@export var packed_ui: PackedScene

func _init() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _ready() -> void:
	Globals.get_mode_building_system().mode_state.mode_changed.connect(_on_mode_changed)
	
func _on_mode_changed(building_mode: GBEnums.Mode) -> void:
	print(building_mode)
	if (building_mode == GBEnums.Mode.OFF):
		mouse_filter = Control.MOUSE_FILTER_STOP
		print("buttons are active")
	else:
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		print("buttons are inactive")
		
func _pressed() -> void:
	Globals.get_UIS().display_new_building_ui(packed_ui, self.get_parent())
	

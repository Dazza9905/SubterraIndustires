extends Panel

@export var level_saver: LevelSaverLoader
@export var placeable_selection_ui: Node
@export var building_ui: Node
@export var main_menu: PackedScene
var is_menu_open: bool = false:
	set(new_val):
		is_menu_open = new_val
		if is_menu_open:
			self.mouse_filter = Control.MOUSE_FILTER_STOP
			visible = true
			get_tree().paused = true
		else:
			self.mouse_filter = Control.MOUSE_FILTER_IGNORE
			visible = false
			get_tree().paused = false
		

func _ready() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if Input.is_action_pressed("toggle_esc_menu"):
			if is_menu_open == false:
				if placeable_selection_ui.visible == false:
					if building_ui.get_child_count() == 0:
						is_menu_open = true
			else: 
				is_menu_open = false
		


func _on_resume_pressed() -> void:
	is_menu_open = false

func _on_save_pressed() -> void:
	level_saver.save_level()

func _on_exit_pressed() -> void:
	Globals.load_level_file_name = ""
	get_tree().change_scene_to_packed(main_menu)

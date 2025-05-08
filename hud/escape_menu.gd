extends Panel

@export var level_saver: LevelSaverLoader
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
			is_menu_open = not is_menu_open
		


func _on_resume_pressed() -> void:
	is_menu_open = false


func _on_save_and_exit_pressed() -> void:
	level_saver.save_level()

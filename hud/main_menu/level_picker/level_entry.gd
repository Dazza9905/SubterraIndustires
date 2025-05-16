extends PanelContainer
class_name LevelEntry

@export var level_name_label: Label
@export var last_played_label: Label
@export var text_box: LineEdit
@export var rename_button: Button
@export var save_button: Button
@export var cancel_button: Button
@export var delete_button: Button
@export var you_sure_button: Button
var you_sure_timer: Timer
var file_name: String
var is_renaming: bool = false:
	set(new_val):
		is_renaming = new_val
		if is_renaming:
			save_button.visible = true
			cancel_button.visible = true
			rename_button.visible = false
			level_name_label.visible = false
			text_box.visible = true
			text_box.text = ""
			text_box.placeholder_text = level_name_label.text
		else:
			save_button.visible = false
			cancel_button.visible = false
			rename_button.visible = true
			level_name_label.visible = true
			text_box.visible = false

func _on_button_pressed() -> void:
	GameManager.load_world(file_name)


func _on_delete_pressed() -> void:
	delete_button.visible = false
	you_sure_button.visible = true
	you_sure_timer = Timer.new()
	add_child(you_sure_timer)
	you_sure_timer.timeout.connect(_on_you_sure_timer_timeout)
	you_sure_timer.start(1)

func _on_rename_pressed() -> void:
	is_renaming = true

func _on_save_rename_pressed() -> void:
	if text_box.text == "":
		is_renaming = false
		return
		
	var uuid_and_extention: String = file_name.right(42)
	var new_file_name: String = text_box.text + uuid_and_extention
	var error = DirAccess.rename_absolute(Globals.GAME_SAVE_PATH + file_name,Globals.GAME_SAVE_PATH + new_file_name)
	
	if error == OK:
		level_name_label.text = text_box.text
		file_name = new_file_name
		is_renaming = false
		print("File renamed successfully to: ", new_file_name)
	else:
		print("Error renaming file: ", error)

func _on_cancel_rename_pressed() -> void:
	is_renaming = false


func _on_you_sure_pressed() -> void:
	GameManager.delete_world(file_name)

func _on_you_sure_timer_timeout():
	delete_button.visible = true
	you_sure_button.visible = false
	you_sure_timer.queue_free()

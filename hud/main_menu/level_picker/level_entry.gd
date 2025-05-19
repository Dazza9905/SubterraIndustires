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
@export var floor_label: Label

var you_sure_timer: Timer
var level_name: String
var uuid: String
var lvl_floor: int
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
	print(level_name)
	print(uuid)
	print(lvl_floor)
	GameManager.load_world(uuid, lvl_floor)


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
		
	for i in range(0, 3):
		var error = DirAccess.rename_absolute(Globals.GAME_SAVE_PATH + "%s-%s-floor%s.json" % [level_name, uuid, i],
		Globals.GAME_SAVE_PATH + "%s-%s-floor%s.json" % [text_box.text, uuid, i])

	
	
	#if error == OK:
		#level_name_label.text = text_box.text
		#level_name = text_box.text
		#is_renaming = false
		#print("File renamed successfully to: ", level_name)
	#else:
		#print("Error renaming file: ", error)
	
	GameManager.reload_worlds.emit()
	

func _on_cancel_rename_pressed() -> void:
	is_renaming = false


func _on_you_sure_pressed() -> void:
	print("%s-%s-floor%s.json" % [level_name, uuid,  lvl_floor])
	GameManager.delete_world("%s-%s-floor%s.json" % [level_name, uuid, lvl_floor])

func _on_you_sure_timer_timeout():
	delete_button.visible = true
	you_sure_button.visible = false
	you_sure_timer.queue_free()
	
	
func get_level_filename(lvl_uuid: String, lvl_floor: int) -> String:
	var dir = DirAccess.open(Globals.GAME_SAVE_PATH)
	var file_name := ""
	var target_file_name := ""
	if dir:
		dir.list_dir_begin()
		file_name = dir.get_next()
		#print(file_name)
		while file_name != "":
			if file_name.contains(lvl_uuid) and file_name.contains("-floor" + str(lvl_floor)):
				target_file_name = file_name
				break
			file_name = dir.get_next()
		dir.list_dir_end()
	return target_file_name

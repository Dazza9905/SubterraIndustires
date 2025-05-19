extends Control

@export var level_entry: PackedScene
@onready var level_picker_container = $MarginContainer/VBoxContainer/MarginContainer/WorldsCointainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.reload_worlds.connect(reload_worlds)
	reload_worlds()


	
func load_levels():
	var dir = DirAccess.open(Globals.GAME_SAVE_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".json"):
				var level_entry := level_entry.instantiate() as LevelEntry
				
				level_entry.uuid = file_name.right(48).left(36)
				level_entry.lvl_floor = int(file_name.right(6).left(1))
				level_entry.level_name = file_name.left(-49)
				level_entry.level_name_label.text = file_name.left(-49)
				match level_entry.lvl_floor:
					0:
						level_entry.floor_label.text = "Ground"
					1:
						level_entry.floor_label.text = "Cave"
					2:
						level_entry.floor_label.text = "Lava"
				var unix_time = FileAccess.get_modified_time(Globals.GAME_SAVE_PATH + file_name)
				level_entry.last_played_label.text = Time.get_datetime_string_from_unix_time(unix_time + 7200).replace("T", " ") #add 2 hours
				
				level_picker_container.add_child(level_entry)
			file_name = dir.get_next()
		dir.list_dir_end()

func reload_worlds() -> void:
	for child in level_picker_container.get_children():
		child.queue_free()
	load_levels()
	

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("uid://cwl1ideqa038k"))


func _on_create_pressed() -> void:
	GameManager.create_world($VBoxContainer/HBoxContainer/LineEdit.text)

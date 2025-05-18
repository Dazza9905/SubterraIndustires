@icon("Save")
extends Node
class_name LevelSaverLoader

@export var game_level: Node2D
@export var tts: TimeTickSystem
@export var root: Node
@export var player: Player
@export var level_info: LevelInfo 

func save_level() -> void:
	var lvl_name = Globals.lvl_uuid.right(48).left(-5)
	tts.paused = true

	DirAccess.make_dir_recursive_absolute(Globals.GAME_SAVE_PATH)
	var file
	if Globals.lvl_uuid == "":	#print("SAVED NEW!")
		var uuid = UUID.v7()
		Globals.lvl_uuid = uuid
		file = FileAccess.open(Globals.GAME_SAVE_PATH + "untitled-%s-floor%s.json" % [Globals.lvl_uuid, Globals.load_floor], FileAccess.WRITE)
		print("FIELNAME NEW: " + "untitled-%s-floor%s.json" % [Globals.lvl_uuid, Globals.load_floor])
	else:
		file = FileAccess.open(Globals.GAME_SAVE_PATH + get_level_filename(Globals.lvl_uuid, Globals.load_floor), FileAccess.WRITE)
		print("FIELNAME EXIST: " + get_level_filename(Globals.lvl_uuid, Globals.load_floor))
	
	var save_dict: Dictionary = {
		level_info = var_to_str(Globals.get_LevelInfo().current_floor),
		player = player.serialize(),
		grid_objects = []
	}

	for node in game_level.get_children():
		if node is GridObject:
			if (node as GridObject).is_in_group("savable"):
				var grid_object_dict = (node as GridObject).serialize()
				if str_to_var(grid_object_dict.uid) != "":
					save_dict.grid_objects.push_back(grid_object_dict)
				#print("GOOOO")
				
	file.store_line(JSON.stringify(save_dict))
	file.close()
	tts.paused = false

func _ready() -> void:
	#print(game_level)
	load_level()
	#get_tree().root.find_child("Game", false, false).process_mode = Node.PROCESS_MODE_INHERIT
	#$"../../TimeTickSystem".paused = false

#func _process(delta: float) -> void:
	#print(game_level)
	#print("1")

func load_level() -> void:
	if Globals.lvl_uuid != "":
		var dir = DirAccess.open(Globals.GAME_SAVE_PATH)
		var file = FileAccess.open(Globals.GAME_SAVE_PATH + get_level_filename(Globals.lvl_uuid, Globals.load_floor), FileAccess.READ)

		var json := JSON.new()
		json.parse(file.get_line())
		var load_dict := json.data as Dictionary
		for go_data: Dictionary in load_dict.grid_objects:
			var grid_object: GridObject = GridObject.deserialize(go_data)
			game_level.add_child(grid_object)
			grid_object.GO_initialize()
			
		player.deserialize(load_dict.player)
	else:
		var file = FileAccess.open("res://levels/floor1.json", FileAccess.READ)
		var json := JSON.new()
		json.parse(file.get_line())
		var load_dict := json.data as Dictionary
		for go_data: Dictionary in load_dict.grid_objects:
			var grid_object: GridObject = GridObject.deserialize(go_data)
			game_level.add_child(grid_object)
			grid_object.GO_initialize()
	
func get_level_filename(lvl_uuid: String, lvl_floor: int) -> String:
	var dir = DirAccess.open(Globals.GAME_SAVE_PATH)
	var file_name := ""
	if dir:
		dir.list_dir_begin()
		file_name = dir.get_next()
		print(file_name)
		while file_name != "":
			if file_name.contains(lvl_uuid) and file_name.contains("-floor" + str(lvl_floor)):
				print(file_name)
				break
			file_name = dir.get_next()
		dir.list_dir_end()
	return file_name

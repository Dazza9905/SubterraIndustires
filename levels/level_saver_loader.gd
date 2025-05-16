@icon("Save")
extends Node
class_name LevelSaverLoader

@export var game_level: Node2D
@export var tts: TimeTickSystem
@export var root: Node
@export var player: Player

func save_level() -> void:
	var lvl_name = Globals.load_level_file_name.right(41).left(-5)
	tts.paused = true
	print("GGR GRR GRR   " + Globals.GAME_SAVE_PATH + Globals.load_level_file_name)
	DirAccess.make_dir_recursive_absolute(Globals.GAME_SAVE_PATH)
	var file
	
	if Globals.load_level_file_name == "":
		print("SAVED NEW!")
		var uuid = UUID.v7()
		file = FileAccess.open(Globals.GAME_SAVE_PATH + "untitled" + "-" + uuid + ".json", FileAccess.WRITE)
		Globals.load_level_file_name = "untitled" + "-" + uuid + ".json"
	else:
		print("SAVED EXISTING!")
		file = FileAccess.open(Globals.GAME_SAVE_PATH + Globals.load_level_file_name, FileAccess.WRITE)
	
	
	var save_dict: Dictionary = {
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
	if Globals.load_level_file_name != "":
		load_level(Globals.load_level_file_name)
	#get_tree().root.find_child("Game", false, false).process_mode = Node.PROCESS_MODE_INHERIT
	#$"../../TimeTickSystem".paused = false

#func _process(delta: float) -> void:
	#print(game_level)
	#print("1")

func load_level(lvl_file: String) -> void:
	var file := FileAccess.open(Globals.GAME_SAVE_PATH + Globals.load_level_file_name, FileAccess.READ)
	print(Globals.GAME_SAVE_PATH + Globals.load_level_file_name)
	#if not file:
		#return
	var json := JSON.new()
	json.parse(file.get_line())
	var load_dict := json.data as Dictionary
	for go_data: Dictionary in load_dict.grid_objects:
		var grid_object: GridObject = GridObject.deserialize(go_data)
		game_level.add_child(grid_object)
		grid_object.GO_initialize()
		
	player.deserialize(load_dict.player)

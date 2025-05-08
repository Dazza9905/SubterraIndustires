@icon("Save")
extends Node
class_name LevelSaverLoader

@export var game_level: Node2D
@export var SAVE_PATH: String = "user://gamesaves/save.json"
@export var tts: TimeTickSystem
@export var root: Node
@export var player: Player

func save_level() -> void:
	tts.paused = true
	
	DirAccess.make_dir_recursive_absolute(Globals.LEVEL_PATH)
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var save_dict: Dictionary = {
		level_name = "untitled",
		player = player.serialize(),
		grid_objects = []
	}
	
	
	
	#save_dict.assign()
	
	for node in game_level.get_children():
		if node is GridObject:
			if (node as GridObject).is_in_group("savable"):
				save_dict.grid_objects.push_back((node as GridObject).serialize())
				#print("GOOOO")
				
	file.store_line(JSON.stringify(save_dict))

func _ready() -> void:
	#print(game_level)
	if Globals.load_level_path != "":
		load_level(Globals.load_level_path)
	#get_tree().root.find_child("Game", false, false).process_mode = Node.PROCESS_MODE_INHERIT
	#$"../../TimeTickSystem".paused = false

#func _process(delta: float) -> void:
	#print(game_level)
	#print("1")

func load_level(lvl_file: String) -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var load_dict := json.data as Dictionary
	for go_data: Dictionary in load_dict.grid_objects:
		var grid_object: GridObject = GridObject.deserialize(go_data)
		game_level.add_child(grid_object)
		grid_object.GO_initialize()
		
	player.deserialize(load_dict.player)

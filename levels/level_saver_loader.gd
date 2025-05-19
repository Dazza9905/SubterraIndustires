@icon("Save")
extends Node
class_name LevelSaverLoader

@export var game_level: Node2D
@export var tts: TimeTickSystem
@export var root: Node
@export var player: Player
@export var level_info: LevelInfo 
@export var grid_state_assigner: GridStateAssigner
@export var bs_target: TileMapLayer

func _ready() -> void:
	load_level()

func save_level() -> void:
	#stop the game
	tts.paused = true

	#Creates game save path, just to be sure
	DirAccess.make_dir_recursive_absolute(Globals.GAME_SAVE_PATH)
	var file
	
	#If level that hasn't been saved, indicated but the lvl_uuid being empty
	if Globals.lvl_uuid == "":
		#Generates uuid and creates a untitled level
		var uuid = UUID.v7()
		Globals.lvl_uuid = uuid
		file = FileAccess.open(Globals.GAME_SAVE_PATH + "untitled-%s-floor%s.json" % [Globals.lvl_uuid, Globals.load_floor], FileAccess.WRITE)
	#If level has coresponding uuid
	else:
		#if the uuid and floor combination doesnt exit, create the file
		if get_level_filename(Globals.lvl_uuid, level_info.current_floor) == "":
			FileAccess.open(Globals.GAME_SAVE_PATH + "%s-%s-floor%s.json" % [get_level_name(Globals.lvl_uuid) ,Globals.lvl_uuid, Globals.load_floor], FileAccess.WRITE)
		
		#open, prepare to write
		file = FileAccess.open(Globals.GAME_SAVE_PATH + get_level_filename(Globals.lvl_uuid, Globals.load_floor), FileAccess.WRITE)
	
	
	#prepare save Dictionary
	var save_dict: Dictionary = {
		level_info = var_to_str(Globals.get_LevelInfo().current_floor),
		player = player.serialize(),
		grid_objects = []
	}

	#write the data to distionary
	for node in game_level.get_children():
		if node is GridObject:
			if (node as GridObject).is_in_group("savable"):
				var grid_object_dict = (node as GridObject).serialize()
				if str_to_var(grid_object_dict.uid) != "":
					save_dict.grid_objects.push_back(grid_object_dict)
				#print("GOOOO")
	
	#serialize the Disct to JSON
	#print(save_dict)
	file.store_line(JSON.stringify(save_dict))
	file.close()
	
	#unpause
	tts.paused = false

func load_level() -> void:
	#if uuid empty
	if Globals.lvl_uuid == "":
		place_default_buildings()
	#if uuid set
	else:
		var file_name = get_level_filename(Globals.lvl_uuid, Globals.load_floor)
		var file
		 
		#if floor save NOT existing
		if file_name == "":
			place_default_buildings()
			#save_level()
		#if floor existing
		else:
			#load
			file = FileAccess.open(Globals.GAME_SAVE_PATH + file_name, FileAccess.READ)
			var json := JSON.new()
			json.parse(file.get_line())
			var load_dict := json.data as Dictionary
			for go_data: Dictionary in load_dict.grid_objects:
				var grid_object: GridObject = GridObject.deserialize(go_data)
				game_level.add_child(grid_object)
				grid_object.GO_initialize()
			player.deserialize(load_dict.player)

func place_default_buildings() -> void:
	var file = FileAccess.open(level_info.template_save_file_path, FileAccess.READ)
	if file:
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

func get_level_name(lvl_uuid: String) -> String:
	var dir = DirAccess.open(Globals.GAME_SAVE_PATH)
	var file_name := ""
	if dir:
		dir.list_dir_begin()
		file_name = dir.get_next()
		print(file_name)
		while file_name != "":
			if file_name.contains(lvl_uuid):
				break
			file_name = dir.get_next()
		dir.list_dir_end()
	return file_name.left(-49)

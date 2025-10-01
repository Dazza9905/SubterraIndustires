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
	
	var world_file
	var character_file
	
	
	#If level that hasn't been saved, indicated but the lvl_uuid being empty
	if Globals.lvl_uuid == "":
		#Generates uuid and creates a untitled level
		var uuid = UUID.v7()
		Globals.lvl_uuid = uuid
		world_file = FileAccess.open(Globals.GAME_SAVE_PATH + "untitled-%s-floor%s.json" % [Globals.lvl_uuid, Globals.load_floor], FileAccess.WRITE)
	#If level has coresponding uuid
	else:
		#if the uuid and floor combination doesnt exit, create the world_file
		if get_level_filename(Globals.lvl_uuid, level_info.current_floor) == "":
			FileAccess.open(Globals.GAME_SAVE_PATH + "%s-%s-floor%s.json" % [get_level_name(Globals.lvl_uuid) ,Globals.lvl_uuid, Globals.load_floor], FileAccess.WRITE)
		
		#open, prepare to write
		world_file = FileAccess.open(Globals.GAME_SAVE_PATH + get_level_filename(Globals.lvl_uuid, Globals.load_floor), FileAccess.WRITE)
	
	
	#prepare level Dictionary
	var save_level_dict: Dictionary = {
		level_info = var_to_str(Globals.get_LevelInfo().current_floor),
		player = player.serialize_for_world(),
		grid_objects = []
	}
	
	#prepare character Dictionary
	var save_character_dict: Dictionary = {
		player = player.serialize_for_character(),
	}

	#write the data to distionary  
	for node in game_level.get_children():
		if node is GridObject:
			if (node as GridObject).is_in_group("savable"):
				var grid_object_dict = (node as GridObject).serialize()
				if str_to_var(grid_object_dict.uid) != "":
					save_level_dict.grid_objects.push_back(grid_object_dict)
				#print("GOOOO")
	
	#serialize the Disct to JSON
	#print(save_level_dict)
	world_file.store_line(JSON.stringify(save_level_dict))
	world_file.close()
	
	character_file.store_line(JSON.stringify(save_character_dict))
	
	#unpause
	tts.paused = false

func load_level() -> void:
	#if uuid empty
	if Globals.lvl_uuid == "":
		place_default_buildings()
	#if uuid set
	else:
		var file_name = get_level_filename(Globals.lvl_uuid, Globals.load_floor)
		var world_file
		 
		#if floor save NOT existing
		if file_name == "":
			place_default_buildings()
			#save_level()
		#if floor existing
		else:
			#load
			world_file = FileAccess.open(Globals.GAME_SAVE_PATH + file_name, FileAccess.READ)
			var json := JSON.new()
			json.parse(world_file.get_line())
			var load_dict := json.data as Dictionary
			for go_data: Dictionary in load_dict.grid_objects:
				var grid_object: GridObject = GridObject.deserialize(go_data)
				game_level.add_child(grid_object)
				grid_object.GO_initialize()
			player.deserialize(load_dict.player)

func place_default_buildings() -> void:
	var world_file = FileAccess.open(level_info.template_save_file_path, FileAccess.READ)
	if world_file:
		var json := JSON.new()
		json.parse(world_file.get_line())
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

func load_characters() -> Array[Dictionary]:
	var characters: Array[Dictionary]
	var dir = DirAccess.open(Globals.CHARACTER_SAVE_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".json"):
				var character_file = FileAccess.open(Globals.CHARACTER_SAVE_PATH + file_name, FileAccess.READ)
				var json := JSON.new()
				json.parse(character_file.get_line())
				var character_dict := json.data as Dictionary
				characters.append(character_dict)
	return characters

func save_character(character_dict: Dictionary, character_name: String) -> void:
	DirAccess.make_dir_recursive_absolute(Globals.CHARACTER_SAVE_PATH)
	character_name = character_name.validate_filename()
	var character_file = FileAccess.open(Globals.CHARACTER_SAVE_PATH + character_name,FileAccess.WRITE)
	character_file.store_line(JSON.stringify(character_dict))

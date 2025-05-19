extends Node


#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.pressed:
		#if Input.is_action_pressed("exit_to_main_menu"):
			#save_world_and_exit()
signal reload_worlds
	
var base_level_scene_uid: String = ""
var load_progress
var array_progress: Array[int]

func load_world(uuid: String = "", lvl_floor: int = 0) -> void:
	Globals.lvl_uuid = uuid
	Globals.load_floor = lvl_floor

	
	match Globals.load_floor:
		0:
			print("LOADING FLOOR 0")
			base_level_scene_uid = "uid://b7mwq0b7atito"
		1:
			print("LOADING FLOOR 1")
			base_level_scene_uid = "uid://dx7w1sqkporio"
		2:
			print("LOADING FLOOR 2")
			base_level_scene_uid = "uid://pl3uyhfmol6b"
	
	ResourceLoader.load_threaded_request(base_level_scene_uid)

func _process(delta: float) -> void:
	
	var _status := ResourceLoader.load_threaded_get_status(base_level_scene_uid, array_progress)
	
	load_progress = array_progress[0]
	if (ResourceLoader.THREAD_LOAD_LOADED == ResourceLoader.load_threaded_get_status(base_level_scene_uid, array_progress)):
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(base_level_scene_uid))

func delete_world(world_name: String) -> void:
	if ResourceLoader.exists(Globals.GAME_SAVE_PATH + world_name):
		var error : Error = DirAccess.remove_absolute(Globals.GAME_SAVE_PATH + world_name)
		reload_worlds.emit()

func save_world():
	print(Globals.get_LevelSaverLoader().name)
	Globals.get_LevelSaverLoader().save_level()

func is_file_accessible(file_path: String) -> bool:
	var file := FileAccess.open(file_path, FileAccess.READ)
	if file:
		file.close()
		return true
	return false

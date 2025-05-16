extends Node

var current_level: String
signal reload_worlds

#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.pressed:
		#if Input.is_action_pressed("exit_to_main_menu"):
			#save_world_and_exit()

func load_world(world_name: String) -> void:
	Globals.load_level_file_name = world_name
	print("grrrr " + world_name)
	self.get_tree().change_scene_to_packed(load("uid://ctc8rnt7qr81d"))
	#if ResourceLoader.exists(Globals.GAME_SAVE_PATH + world_name):
		#var current_world: PackedScene = load(Globals.GAME_SAVE_PATH + world_name) as PackedScene
		##var current_world_instance: Node = current_world.instantiate()
		#current_level = world_name
		#self.get_tree().change_scene_to_packed(current_world)
		
#func set_owner_recursively(node: Node, owner_node: Node) -> void:
	#for child in node.get_children():
		#child.owner = owner_node
		#set_owner_recursively(child, owner_node)

func delete_world(world_name: String) -> void:
	if ResourceLoader.exists(Globals.GAME_SAVE_PATH + world_name):
		var error : Error = DirAccess.remove_absolute(Globals.GAME_SAVE_PATH + world_name)

	reload_worlds.emit()

func is_file_accessible(file_path: String) -> bool:
	var file := FileAccess.open(file_path, FileAccess.READ)
	if file:
		file.close()
		return true
	return false

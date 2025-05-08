extends Node

var current_level: String
signal reload_worlds

#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.pressed:
		#if Input.is_action_pressed("exit_to_main_menu"):
			#save_world_and_exit()

func load_world(world_name: String) -> void:
	Globals.load_level_path = world_name
	self.get_tree().change_scene_to_packed(load("uid://ctc8rnt7qr81d"))
	#if ResourceLoader.exists(Globals.LEVEL_PATH + world_name):
		#var current_world: PackedScene = load(Globals.LEVEL_PATH + world_name) as PackedScene
		##var current_world_instance: Node = current_world.instantiate()
		#current_level = world_name
		#self.get_tree().change_scene_to_packed(current_world)
		
#func set_owner_recursively(node: Node, owner_node: Node) -> void:
	#for child in node.get_children():
		#child.owner = owner_node
		#set_owner_recursively(child, owner_node)

func delete_world(world_name: String) -> void:
	if ResourceLoader.exists(Globals.LEVEL_PATH + world_name):
		var error : Error = DirAccess.remove_absolute(Globals.LEVEL_PATH + world_name)
		if(error == OK):
			print("File deleted successfully.")
		else:
			print("Failed to delete the file. Error code: ", error)
	else:
		print("File does not exist: ", Globals.LEVEL_PATH + world_name)
	reload_worlds.emit()

#func save_world_and_exit() -> void:
	#self.get_tree().paused = true
	#var world : PackedScene = PackedScene.new()
	#set_owner_recursively(get_node("/root/Game"), get_node("/root/Game"))
	#world.pack(get_node("/root/Game"))
	#
	#delete_world(current_level)
	#create_world_from_packed(current_level, world)
	#
	#self.get_tree().change_scene_to_packed(load("res://hud/main_menu.tscn"))
	#reload_worlds.emit()

#func create_world(world_name: String) -> void:
	#if world_name.strip_edges() != "":
		#var template_path : String = "res://gameplay.tscn"
		#if ResourceLoader.exists(template_path):
			#var blank_world : Resource = load(template_path).duplicate(true)
			#var new_world_path : String = Globals.LEVEL_PATH + world_name + ".tscn"
			#var error : Error = ResourceSaver.save(blank_world, new_world_path)
			#if error == OK:
				#print("World created successfully at: ", new_world_path)
			#else:
				#print("Error saving world: ", error)
		#else:
			#print("Template file does not exist: ", template_path)
	#reload_worlds.emit()

#func create_world_from_packed(world_name: String, packed_scene: PackedScene) -> void:
	#if world_name.strip_edges() != "":
		#var new_world_path : String = Globals.LEVEL_PATH + world_name
		#var error : Error = ResourceSaver.save(packed_scene, new_world_path)
		#if error == OK:
			#print("World created successfully at: ", new_world_path)
		#else:
			#print("Error saving world: ", error)
	#else:
		#print("Template file does not exist")
	#reload_worlds.emit()

func is_file_accessible(file_path: String) -> bool:
	var file := FileAccess.open(file_path, FileAccess.READ)
	if file:
		file.close()
		return true
	return false

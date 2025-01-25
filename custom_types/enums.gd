extends Node

#set to Global from Project Settings
enum MATERIAL_ITEM {
	NONE, #used also as ANY (when filtering)
	IRON,
	COPPER,
	COAL,
	GOLD,
	IRON_INGOT,
	CARBON
}

var recipes: Array[Recipe]
var items: Array[Item]

func load_items():
	var dir = DirAccess.open(Globals.ITEM_PATH)

	if dir:
		dir.list_dir_begin()
		var folder_name = dir.get_next()
		while folder_name != "":
			if dir.current_is_dir():
				print("Found directory: " + folder_name)
				print(dir.change_dir(folder_name))
				var inner_file = dir.get_next()
				print(inner_file)
				while inner_file != "":
					print(inner_file)
					if(inner_file.begins_with("item_") and inner_file.ends_with(".tres")):
						print("loading resource: ", Globals.ITEM_PATH + folder_name + inner_file)
						var resource = load(Globals.ITEM_PATH + folder_name + inner_file)
						if(resource is Recipe):
							items.append(resource)
							print("loaded as Recepie")
					inner_file = dir.get_next()
				dir.change_dir("../")
			else:
				print("Found file: " + folder_name + " -ignored")
			folder_name = dir.get_next()

	else:
		print("An error occurred when trying to access the path.")

	print("Item array:")
	for item in items:
		print(item.name)
	print("Thats all")
	
func load_recipes():
	var dir = DirAccess.open(Globals.RECIPE_PATH)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				if(file_name.begins_with("recipe_") and file_name.ends_with(".tres")):
					var resource = load(Globals.RECIPE_PATH + file_name)
					if(resource is Recipe):
						recipes.append(resource)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

	print("Recipe array:")
	for recipe in recipes:
		print(recipe.name)
	print("Thats all")


func _init() -> void:
	load_recipes()
	load_items()

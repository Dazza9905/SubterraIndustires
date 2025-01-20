extends Node

#set to Global from Project Settings
enum MATERIAL_ITEM {
	NONE, #used also as ANY (when filtering)
	IRON,
	COPPER,
	COAL,
	GOLD,
	IRON_INGOT
}

var recipes: Array[Recipe]

func _init() -> void:
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

	for recipe in recipes:
		print(recipe.name)
	print("Thats all")

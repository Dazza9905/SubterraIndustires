extends Node

#set to Global from Project Settings
enum MATERIAL_ITEM {
	NONE, #used also as ANY (when filtering)
	IRON,
	COPPER,
	COAL,
	GOLD,
	IRON_INGOT,
	CARBON,
	GOLD_INGOT,
	STEEL_INGOT,
	HP_STEEL_INGOT,
	CRYSTAL,
	THUNGSTEN_ORE,
	THUNGSTEN_INGOT,
	COPPER_INGOT,
	BROZNE_INGOT,
	LEAD_ORE,
	LEAD_INGOT,
	DIRTY_GOO,
	GOO,
	WATER,
	SOLID_GOO,
	BLANK_BOARD,
	COPPER_WIRE,
	GOLD_WIRE,
	COPPER_INSULATED_WIRE,
	GOLD_INSULATED_WIRE,
	MONO_CHIP,
	POLY_CHIP,
	COAL_DUST,
	IRON_PLATE,
	COPPER_PLATE,
	GOLD_PLATE,
	IRON_ROD,
	IRON_FRAME,
	ROCK,
	COMPUTER,
	RADAR,
	WARP_COPE,
	ENGINES,
	ROCKET_FUEL,
	CRYSTAL_DUST,
	THUNGSTEN_PLATE,
	DRILL_IRON,
	DRILL_THUNGSTEN,
	IRON_GEAR,
	THUNGSTEN_GEAR,
	THUNGSTEN_ROD
}

var recipes: Array[Recipe]
var items: Array[Item]

func filter_recipes_by_machine(machine: String) -> Array[Recipe]:
	var filtered_recipes: Array[Recipe] = []
	for r in recipes:
		if r.valid_machines.has(machine):
			filtered_recipes.append(r)
	return filtered_recipes


func load_items() -> void:
	load_resources_recursively(Globals.ITEM_PATH, r"^item_.*\.tres$", items)
	#var items_names: String = ""
	#for item in items:
		#items_names += item.name + "   "
	##print("Loaded items:\t\t", items_names)
	
func load_recipes() -> void:
	load_resources_recursively(Globals.RECIPE_PATH, r"^recipe_.*\.tres$", recipes)
	#var recipes_names: String = ""
	#for recipe in recipes:
		#recipes_names += recipe.name
	##print("Loaded recipes:\t\t", recipes_names)

func load_resources_recursively(base_path: String, file_regex: String, storage: Array, recursive := true) -> void:
	var dir := DirAccess.open(base_path)
	if not dir:
		push_error("Failed to open directory: " + base_path)
		return
	
	dir.list_dir_begin() # skip hidden
	var entry := dir.get_next()
	var pattern := RegEx.new()
	pattern.compile(file_regex)

	while entry != "":
		if entry.begins_with("."):
			pass
			# skip system/hidden
		elif dir.current_is_dir():
			# Recurse if folders found (and recursion allowed)
			if recursive:
				var sub_path = base_path + entry + "/"
				load_resources_recursively(sub_path, file_regex, storage, recursive)
		else:
			# Check filename against regex
			if pattern.search(entry):
				var resource_path = base_path + entry
				var res := load(resource_path)
				if res:
					storage.append(res)
		entry = dir.get_next()
	dir.list_dir_end()


func _init() -> void:
	load_recipes()
	load_items()

extends Component
class_name CrafterComponent

signal recipe_changed
signal item_crafted
signal craft_progress_changed

@export var progress_label: Label

@export var recipe: Recipe:
	set(new_recipe):
		recipe = new_recipe
		craft_progress = 0
		recipe_changed.emit()
@export var inputs: Array[SlotComponent]
@export var outputs: Array[SlotComponent]
@export var speed_multiplier: float
@export var craft_progress: int = 0:
	set(new_progress):
		craft_progress = new_progress
		craft_progress_changed.emit()

var objective_system: ObjectiveSystem


#signal produced_items(item: Item, amount: int)

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)
	objective_system = Globals.get_ObjectiveSystem()

func _on_machanine_tick() -> void:
	var target_outputs: Array[int]
	
	if if_can_craft(target_outputs):
		print("asd")
		craft_progress += 1
		
		if craft_progress == recipe.ticks_to_craft:
			process_items(target_outputs)
			craft_progress = 0
		
		#if craft_progress < recipe.ticks_to_craft:
			#if craft_progress == recipe.ticks_to_craft:
				#craft_progress == 0
			#if can_craft:
				#craft_progress = craft_progress + 1
				#craft_progress_changed.emit(float(craft_progress) / float(recipe.ticks_to_craft))
			#
	#
		#if craft_progress == recipe.ticks_to_craft:
			#if can_craft:
				#process_items(target_outputs)
				#craft_progress = 0
				#item_crafted.emit()
				#craft_progress_changed.emit(float(craft_progress) / float(recipe.ticks_to_craft))

func if_can_craft(target_outputs: Array[int]) -> bool:
	if recipe == null:
		return false
	for in_ingradient in recipe.input_ingredients:
		var ingredient_present: bool = false
		for in_slot in inputs:
			if(in_slot.item == in_ingradient.item and in_slot._amount >= in_ingradient.amount):
				ingredient_present = true
				break
		if(ingredient_present != true):
			return false
	
	for out_product in recipe.output_products:
		var avalible_output: bool = false
		for i in range(0, outputs.size()):
			if(outputs[i].can_give_item(out_product.item, out_product.amount) and not target_outputs.has(i)):
				avalible_output = true
				target_outputs.append(i)
				break
		if(avalible_output != true):
			return false
	return true
	
func process_items(target_outputs: Array[int]) -> void:
	if target_outputs.size() == 0:
		assert("Crafting failed. Tried to craft and certainoli did not validate if crafting is possible")
	#IF WE GOT HERE, EVERITHING SHOULD BE GOOD TO GO
	for in_ingredient in recipe.input_ingredients:
		for input in inputs:
			var result: Item = input.take_sigle_type(in_ingredient.item.type, in_ingredient.amount)
			if result:
				break
				
	for i in range(0, target_outputs.size()):
		outputs[i].give_item(recipe.output_products[i].item, recipe.output_products[i].amount)
		objective_system.complete_produce(recipe.output_products[i].item, recipe.output_products[i].amount)

func serialize() -> Dictionary:
	var save_dict: Dictionary = {
		recipe = var_to_str(recipe),

	}
	return save_dict

func deserialize(comp_data: Dictionary) -> void:
	recipe = str_to_var(comp_data.recipe)

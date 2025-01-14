extends Component
class_name CrafterComponent

@export var recipe: Recipe
@export var inputs: Array[SlotComponent]
@export var outputs: Array[SlotComponent]
@export var speed_multiplier: float

@export var craft_progress: int

func connect_to_tick() -> void:
	Globals.get_tts().machine_tick.connect(_on_machanine_tick)

func _on_machanine_tick() -> void:
	for in_ingradient in recipe.input_ingredients:
		var ingredient_present: bool = false
		for in_slot in inputs:
			if(in_slot.item == in_ingradient.item and in_slot._amount >= in_ingradient.amount):
				ingredient_present = true
				break
		if(ingredient_present != true):
			return
	
	var used_outputs: Array[int]
	for out_product in recipe.output_products:
		var avalible_output: bool = false
		for i in range(0, outputs.size()):
			if(outputs[i].can_give_item(out_product.item, out_product.amount) and not used_outputs.has(i)):
				avalible_output = true
				used_outputs.append(i)
				break
		if(avalible_output != true):
			return
		
	#IF WE GOT HERE, EVERITHING SHOULD BE GOOD TO GO
	

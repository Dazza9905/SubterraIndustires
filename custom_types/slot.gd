extends Component
class_name SlotComponent

@export var capacity: int = 1
@export var item_sprite: Sprite2D
@export var amount: int = 0:
	set(new_amount):
		if(new_amount <= 0):
			item_sprite.visible = false
		else:
			item_sprite.visible = true
		amount = new_amount
@export var item: Enums.MATERIAL_ITEM = Enums.MATERIAL_ITEM.NONE:
	set(new_item):
		if(new_item == Enums.MATERIAL_ITEM.NONE):
			item_sprite.visible = false
		else:
			item_sprite.visible = true
		item = new_item

#ANY
func request_any_type() -> Enums.MATERIAL_ITEM:
	if (is_empty()):
		return Enums.MATERIAL_ITEM.NONE
	else:
		return give_item()

#SINGLE
func request_sigle_type(passed_item_type: Enums.MATERIAL_ITEM) -> Enums.MATERIAL_ITEM:
	if (is_empty()):
		return Enums.MATERIAL_ITEM.NONE
	elif (item == passed_item_type):
		return give_item()
	return Enums.MATERIAL_ITEM.NONE
	
#MULTI
func request_multi_type(passed_item_types: Array[Enums.MATERIAL_ITEM]) -> Enums.MATERIAL_ITEM:
	if (is_empty()):
		return Enums.MATERIAL_ITEM.NONE
	else: for item_type in passed_item_types:
		if (item == item_type):
			return give_item()
	return Enums.MATERIAL_ITEM.NONE
		

func give_item() -> Enums.MATERIAL_ITEM:
	print("give_item")
	amount = amount - 1
	if(amount == 0): # SET ITEM TO NONE
		var temp_item: Enums.MATERIAL_ITEM = item
		item = Enums.MATERIAL_ITEM.NONE
		return temp_item
	return item

func is_empty() -> bool:
	return item == Enums.MATERIAL_ITEM.NONE or capacity == 0

func pass_item(passed_item_type: Enums.MATERIAL_ITEM) -> bool:
	if (item == Enums.MATERIAL_ITEM.NONE or item == passed_item_type):
		item = passed_item_type
		amount += 1
		return true
	return false
	
func connect_to_tick() -> void:
	pass

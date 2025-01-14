extends Component
class_name SlotComponent

@export var capacity: int = 1
@export var item_sprite: Sprite2D
@export var _amount: int = 0:
	set(new_amount):
		_amount = new_amount
		if(_amount <= 0):
			if(item_sprite is Sprite2D):
				item_sprite.visible = false
			item = Enums.MATERIAL_ITEM.NONE
		else:
			if(item_sprite is Sprite2D):
				item_sprite.visible = true
@export var item: Enums.MATERIAL_ITEM = Enums.MATERIAL_ITEM.NONE:
	set(new_item):
		item = new_item
		if(item == Enums.MATERIAL_ITEM.NONE):
			if(item_sprite is Sprite2D):
				item_sprite.visible = false
		else:
			if(item_sprite is Sprite2D):
				item_sprite.visible = true
				var item_name: String =  str(Enums.MATERIAL_ITEM.keys()[item]).to_lower()
				item_sprite.texture = load(Globals.ITEM_TEX_PATH + item_name + "/" + item_name + "_sprite.png")
				print(Globals.ITEM_TEX_PATH + item_name + "/" + item_name + "_sprite.png")

func give_item(passed_item: Enums.MATERIAL_ITEM, passed_ammount: int = 1) -> Error:
	if(passed_item == Enums.MATERIAL_ITEM.NONE):
		return FAILED
	elif(item != passed_item and item != Enums.MATERIAL_ITEM.NONE):
		return FAILED
	else:
		if(_amount + passed_ammount > capacity):
			return FAILED
		else:
			_amount = _amount + passed_ammount
			item = passed_item
			return OK
			
func can_give_item(passed_item: Enums.MATERIAL_ITEM, passed_amount: int = 1) -> bool:
	if(passed_item == Enums.MATERIAL_ITEM.NONE):
		return false
	elif(item != passed_item and item != Enums.MATERIAL_ITEM.NONE):
		return false
	else:
		if(_amount + passed_amount > capacity):
			return false
		else:
			return true

func take(passed_amount: int = 1) -> Enums.MATERIAL_ITEM:
	var temp_item: Enums.MATERIAL_ITEM = item
	_amount = _amount - passed_amount
	return temp_item


#ANY
func take_any_type() -> Enums.MATERIAL_ITEM:
	if (is_empty()):
		return Enums.MATERIAL_ITEM.NONE
	else:
		return take()

#SINGLE
func take_sigle_type(passed_item_type: Enums.MATERIAL_ITEM, passed_amount: int = 1) -> Enums.MATERIAL_ITEM:
	if (is_empty()):
		return Enums.MATERIAL_ITEM.NONE
	else:
		if (item == passed_item_type and _amount >= passed_amount):
			return take(passed_amount)
	return Enums.MATERIAL_ITEM.NONE
	
#MULTI
func take_multi_type(passed_item_types: Array[Enums.MATERIAL_ITEM], passed_amount: int = 1) -> Enums.MATERIAL_ITEM:
	if (is_empty()):
		return Enums.MATERIAL_ITEM.NONE
	else: 
		for item_type in passed_item_types:
			if (item == item_type and _amount >= passed_amount):
				return take(passed_amount)
	return Enums.MATERIAL_ITEM.NONE



func is_empty() -> bool:
	return item == Enums.MATERIAL_ITEM.NONE or _amount == 0
	
	
	
func connect_to_tick() -> void:
	pass

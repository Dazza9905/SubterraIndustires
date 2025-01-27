extends Component
class_name SlotComponent

@export var capacity: int = 1
@export var item_sprite: Sprite2D
@export var _amount: int = 0:
	set(new_amount):
		_amount = new_amount
		if(_amount > 0):
			if item_sprite:
				item_sprite.visible = true
		else:
			item = null
			if item_sprite:
				item_sprite.visible = false
@export var item: Item:
	set(new_item):
		item = new_item
		
		if item_sprite:
			if item:
				item_sprite.visible = true
				item_sprite.texture = item.texture
			else:
				item_sprite.visible = false
			

func give_item(passed_item: Item, passed_amount: int = 1) -> Error:
	match [passed_item, item]:
		[null, _]:
			# Case 1: passed_item is null
			return FAILED

		[_, null]:
			# Case 2: slot is empty (item == null)
			if passed_amount > capacity:
				return FAILED
			item = passed_item
			_amount = passed_amount
			return OK

		[_, _]:
			# Case 3: slot already has an item
			if item.type != passed_item.type:
				return FAILED
			if _amount + passed_amount >= capacity:
				return FAILED
			_amount += passed_amount
			return OK

		_:
			return FAILED

			
func can_give_item(passed_item: Item, passed_amount: int = 1) -> bool:
	match [passed_item, item]:
		[null, _]:
			# Case 1: passed_item is null
			return false

		[_, null]:
			# Case 2: slot is empty (item == null)
			if passed_amount > capacity:
				return false
			return true

		[_, _]:
			# Case 3: slot already has an item
			if item.type != passed_item.type:
				return false
			if _amount + passed_amount > capacity:
				return false
			return true

		_:
			return false

func take(passed_amount: int = 1) -> Item:
	var temp_item: Item = item
	_amount = _amount - passed_amount
	return temp_item


#ANY
func take_any_type():
	if (is_empty()):
		return null
	else:
		return take()

#SINGLE
func take_sigle_type(passed_item_type: Enums.MATERIAL_ITEM):
	if (is_empty()):
		return null
	else:
		if (item.type == passed_item_type):
			return take()
	return null
	
#MULTI
func take_multi_type(passed_item_types: Array[Enums.MATERIAL_ITEM]):
	if (is_empty()):
		return null
	else: 
		for item_type in passed_item_types:
			if (item.type == item_type):
				return take()
	return null



func is_empty() -> bool:
	return item == null or _amount == 0
	
	
	
func connect_to_tick() -> void:
	pass

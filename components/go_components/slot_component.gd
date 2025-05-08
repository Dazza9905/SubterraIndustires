extends Component
class_name SlotComponent

signal slot_contents_changed


@export var capacity: int = 1
@export var _amount: int = 0:
	set(new_amount):
		_amount = new_amount
		if(_amount > 0):
			pass
		else:
			item = null
		slot_contents_changed.emit()
@export var item: Item:
	set(new_item):
		item = new_item
		slot_contents_changed.emit()

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
			if _amount + passed_amount > capacity:
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


#ANY
func take(passed_amount: int = 1) -> Item: # -1 <- max amount
	if (is_empty()):
		return null
	else:
		if _amount >= passed_amount:
			#if passed_amount == -1:
				#passed_amount = _amount
			var temp_item: Item = item
			_amount = _amount - passed_amount
			return temp_item
		else:
			return null

#SINGLE
func take_sigle_type(passed_item_type: Enums.MATERIAL_ITEM, passed_amount = 1) -> Item:
	if (is_empty()):
		return null
	else:
		if (item.type == passed_item_type):
			return take(passed_amount)
	return null
	
#MULTI
func take_multi_type(passed_item_types: Array[Enums.MATERIAL_ITEM], passed_amount = 1) -> Item:
	if (is_empty()):
		return null
	else: 
		for item_type in passed_item_types:
			if (item.type == item_type):
				return take(passed_amount)
	return null

func is_empty() -> bool:
	return _amount == 0 or item == null

func connect_to_tick() -> void:
	pass

func serialize() -> Dictionary:
	var save_dict: Dictionary = {
		capacity = var_to_str(capacity),
		item = var_to_str(item),
		amount = var_to_str(_amount)
	}
	return save_dict
	
func deserialize(comp_data: Dictionary) -> void:
	capacity = str_to_var(comp_data.capacity)
	item = str_to_var(comp_data.item)
	_amount = str_to_var(comp_data.amount)
	

extends Resource
class_name ItemStack

@export var item: Item
@export var amount: int = 0


static var EMPTY: 
	get():
		ItemStack.create(null, 0)

static func create(p_item: Item, p_amount: int) -> ItemStack:
	var item_stack: ItemStack = ItemStack.new()
	item_stack.item = p_item
	item_stack.amount = p_amount
	return item_stack


func has_enough_of(item_stack: ItemStack) -> bool:
	if item == item_stack.item and amount >= item_stack.amount:
		return true
	else:
		return false

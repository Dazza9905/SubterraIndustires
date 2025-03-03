extends Resource
class_name DraggedItem

var item: Item
var source_slot_component: SlotComponent

func _init(dragged_item: Item, source_slot: SlotComponent) -> void:
	self.item = dragged_item
	self.source_slot_component = source_slot

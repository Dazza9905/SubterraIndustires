extends ComponentUI
class_name SlotComponentUI

@export var ui_link_id: String
@export var item_count_label: Label
@export var item_texture: TextureRect

var slot_component: SlotComponent

func link_to_component(components: Array[Component]) -> void:
	var is_linked: bool = false
	for comp in components:
		if is_linked == false:
			if comp is SlotComponent and comp.ui_link_id == ui_link_id:
				print(self.name, " linked to ", comp.name)
				slot_component = comp
				slot_component.slot_contents_changed.connect(update_ui)
				update_ui()
				is_linked = true
	if not is_linked:
		assert(self.name, " did not link!")


func update_ui():
	if slot_component._amount <= 1:
		item_count_label.visible = false
	else:
		item_count_label.visible = true
		
	item_count_label.text = str(slot_component._amount)
	
	if slot_component.item:
		item_texture.texture = slot_component.item.texture
		item_texture.visible = true
	else:
		item_texture.visible = false
	
	
func _get_drag_data(at_position: Vector2) -> DraggedItem:
	if slot_component.item is Item:
		var dragged_item: DraggedItem = DraggedItem.new(slot_component.item, slot_component)
		
		var item_drag_preview = TextureRect.new()
		item_drag_preview.texture = slot_component.item.texture
		item_drag_preview.expand_mode = 1
		item_drag_preview.size = Vector2(48, 48)
		item_drag_preview.position = Vector2(-24, -24)
		
		var preview_parent: Control = Control.new()
		preview_parent.add_child(item_drag_preview)
	
		set_drag_preview(preview_parent)
		
		return dragged_item
	else:
		return null
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is DraggedItem:
		if slot_component.item == null and slot_component._amount < slot_component.capacity:
			return true
		elif slot_component.item == (data as DraggedItem).item and slot_component._amount < slot_component.capacity:
			return true
		else:
			return false
	else:
		return false
		
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	(data as DraggedItem).source_slot_component._amount -= 1
	slot_component._amount += 1
	slot_component.item = (data as DraggedItem).item
	print("dropped ", data)

extends ComponentUI
class_name SlotComponentUI

@export var ui_link_id: String
@export var item_count_label: Label
@export var item_texture: TextureRect

var slot_component: SlotComponent

func link_to_component(components: Array[Component]) -> void:
	var is_linked: bool = false
	for comp in components:
		if comp is SlotComponent and comp.ui_link_id == ui_link_id:
			print(self.name, " linked to ", comp.name)
			slot_component = comp
			slot_component.slot_contents_changed.connect(update_ui)
			update_ui()
			break
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
	

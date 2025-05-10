extends OptionButton
class_name SpawnerCompUI

@export var ui_link_id: String

var creative_gen: SpawnerComp

func link_to_component(components: Array[Component]) -> void:
	var is_linked: bool = false
	for comp in components:
		if comp is SpawnerComp and comp.ui_link_id == ui_link_id:
			#print(self.name, " linked to ", comp.name)
			creative_gen = comp
			self.selected = Enums.items.find(creative_gen.item)+1
			break
	if not is_linked:
		assert(self.name, " did not link!")



func _init() -> void:
	add_item("none")
	for item in Enums.items:
		add_icon_item(item.texture, item.name)

func _on_item_selected(index: int) -> void:
	if index == 0:
		creative_gen.item = null
		return
	creative_gen.item = Enums.items[index-1]

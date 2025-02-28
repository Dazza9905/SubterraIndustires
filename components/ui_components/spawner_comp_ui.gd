extends ComponentUI
class_name SpawnerCompUI

@export var ui_link_id: String
@export var option_button: OptionButton

var creative_gen: SpawnerComp

func link_to_component(components: Array[Component]) -> void:
	var is_linked: bool = false
	for comp in components:
		if comp is SpawnerComp and comp.ui_link_id == ui_link_id:
			print(self.name, " linked to ", comp.name)
			creative_gen = comp
			option_button.selected = Enums.items.find(creative_gen.item)
			break
	if not is_linked:
		assert(self.name, " did not link!")


func _on_option_button_item_selected(index: int) -> void:
	creative_gen.item = Enums.items[index]

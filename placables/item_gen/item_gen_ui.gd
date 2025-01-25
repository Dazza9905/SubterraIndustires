extends GridObjectUI

var creative_gen_comp: CreativeGenComp

func _ready() -> void:
	var comps = get_GO_componets()
	for node: Node in comps:
		if(node is CreativeGenComp):
			creative_gen_comp = node
	

func _on_option_button_item_selected(index: int) -> void:
	creative_gen_comp.item = Enums.items[index]

func _on_close_ui_pressed() -> void:
	queue_free()

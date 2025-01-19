extends GridObjectUI

var crafter_comp: CrafterComponent

func _ready() -> void:
	var comps = get_GO_componets()
	for node: Node in comps:
		if(node is CrafterComponent):
			crafter_comp = node
	

func _on_option_button_item_selected(index: int) -> void:
	crafter_comp.recipe = Globals.recipes[index]

func _on_close_ui_pressed() -> void:
	queue_free()

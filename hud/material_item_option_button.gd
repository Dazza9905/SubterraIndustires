extends OptionButton


	
func _init() -> void:
	var i: int = 0
	for each: String in Enums.MATERIAL_ITEM:
		add_item(each, i)
		i += 1 
	
#func _ready() -> void:
	#selected = get_parent().get_parent().creative_gen_comp.item
	

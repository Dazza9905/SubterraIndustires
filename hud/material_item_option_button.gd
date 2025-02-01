extends OptionButton


	
func _init() -> void:
	var i: int = 0
	for item in Enums.items: #TODO TU ZACNi
		add_icon_item(item.texture, item.name)
		i += 1 
	
#func _ready() -> void:
	#selected = get_parent().get_parent().creative_gen_comp.item
	
